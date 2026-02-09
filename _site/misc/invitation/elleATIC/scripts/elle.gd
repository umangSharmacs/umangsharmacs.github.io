extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
const CLIMB_SPEED = 200.0
const SHODDY_TILE_TIMER = 1
var health = 5


@onready var hazard_detector = $HazardDetector
# Add this line - adjust path based on your scene structure
@onready var health_ui = get_node("../CanvasLayer/HBoxContainer")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Track active shoddy tiles
var active_shoddy_tiles = {}

# Track last hazard tile touched
var last_hazard_tile = null

# Ladder climbing
var is_on_ladder = false
var ladder_tilemap = null

# Interaction detection
var nearby_npc = null

func _ready():
	collision_layer = 1
	collision_mask = 7  # Collides with layers 1, 2, 3 (not 4 for ladders)
	# Make sure player is in "player" group
	add_to_group("player")
	# Initialize health display
	if health_ui:
		health_ui.update_hearts(health)

func _physics_process(delta):
	# Check if player is overlapping a ladder tile
	check_ladder_overlap()
	
	# Ladder climbing logic
	if is_on_ladder:
		var vertical_input = Input.get_axis("ui_up", "ui_down")
		if vertical_input != 0:
			# Climbing - no gravity
			velocity.y = vertical_input * CLIMB_SPEED
		else:
			# Holding on ladder - no movement
			velocity.y = 0
		
		# Can still move left/right on ladder
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Can jump off ladder
		if Input.is_action_just_pressed("ui_accept"):
			is_on_ladder = false
			velocity.y = JUMP_VELOCITY
	else:
		# Normal platformer physics
		# Add the gravity
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle jump
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Track if we're currently touching any hazard
	var touching_hazard = false
	var current_hazard_tile = null
	
	# Check if we collided with a hazard
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is TileMap:
			# Get which tile we hit
			var tilemap = collider as TileMap
			var collision_point = collision.get_position()
			var tile_pos = tilemap.local_to_map(collision_point)
			var tile_data = tilemap.get_cell_tile_data(0, tile_pos)
			
			if tile_data:
				var tile_type = tile_data.get_custom_data("tile_type")
				match tile_type:
					"terrain":
						pass
					"hazard":
						touching_hazard = true
						current_hazard_tile = tile_pos
						# Only take damage if it's a NEW hazard tile
						if last_hazard_tile != tile_pos:
							take_damage()
						last_hazard_tile = tile_pos
					"shoddy":
						start_shoddy_timer(tilemap, tile_pos)
						
	# Reset last_hazard_tile when not touching any hazard
	if not touching_hazard:
		last_hazard_tile = null

func _input(event):
	# Handle NPC interaction with 'E' key
	if event.is_action_pressed("interact") and nearby_npc != null:
		nearby_npc.trigger_interaction()
		print("Player pressed E near NPC!")

func check_ladder_overlap():
	# Get the tilemap
	var tilemap = get_node("../TileMap")  # Adjust path as needed
	
	# Get player's current tile position
	var player_tile_pos = tilemap.local_to_map(tilemap.to_local(global_position))
	var tile_data = tilemap.get_cell_tile_data(0, player_tile_pos)
	
	if tile_data:
		var tile_type = tile_data.get_custom_data("tile_type")
		if tile_type == "ladder":
			is_on_ladder = true
			ladder_tilemap = tilemap
			return
	
	# Not on ladder
	is_on_ladder = false
	ladder_tilemap = null

func set_nearby_npc(npc):
	"""Called by NPC when player enters interaction range"""
	nearby_npc = npc
	print("NPC nearby: ", npc)

func clear_nearby_npc(npc):
	"""Called by NPC when player exits interaction range"""
	if nearby_npc == npc:
		nearby_npc = null
		print("NPC left range")

func take_damage():
	health -= 1
	print("Ouch! Health: ", health)
	# Update UI
	if health_ui:
		health_ui.update_hearts(health)
	if health <= 0:
		die()

func die():
	print("Player died!")
	# Add death logic here (restart level, game over screen, etc.)
	get_tree().reload_current_scene()

func _process(delta):
	# Update all shoddy tile timers
	var tiles_to_remove = []
	
	for tile_key in active_shoddy_tiles.keys():
		var tile_info = active_shoddy_tiles[tile_key]
		tile_info["time_left"] -= delta
		
		if tile_info["time_left"] <= 0:
			# Remove the tile
			var tilemap = tile_info["tilemap"]
			var pos = tile_info["position"]
			
			# Spawn falling sprite + particles
			spawn_falling_tile(tilemap, pos)
			
			tilemap.erase_cell(0, pos)
			tiles_to_remove.append(tile_key)
	
	# Clean up finished timers
	for tile_key in tiles_to_remove:
		active_shoddy_tiles.erase(tile_key)

func start_shoddy_timer(tilemap: TileMap, tile_pos: Vector2i):
	var tile_key = str(tile_pos)
	
	# Only start timer if not already counting down
	if tile_key not in active_shoddy_tiles:
		active_shoddy_tiles[tile_key] = {
			"tilemap": tilemap,
			"position": tile_pos,
			"time_left": SHODDY_TILE_TIMER,
			"warning_shown": false
		}
		# Also spawn particles
		spawn_particles(tilemap, tile_pos)

func spawn_falling_tile(tilemap: TileMap, tile_pos: Vector2i):
	# Get tile info to recreate it as a sprite
	var source_id = tilemap.get_cell_source_id(0, tile_pos)
	var atlas_coords = tilemap.get_cell_atlas_coords(0, tile_pos)
	
	# Create a sprite that looks like the tile
	var falling_sprite = Sprite2D.new()
	
	# Get the tileset texture
	var tileset = tilemap.tile_set
	var source = tileset.get_source(source_id)
	falling_sprite.texture = source.texture
	
	# Set the correct region from atlas
	var tile_size = tileset.tile_size
	falling_sprite.region_enabled = true
	falling_sprite.region_rect = Rect2(
		atlas_coords.x * tile_size.x,
		atlas_coords.y * tile_size.y,
		tile_size.x,
		tile_size.y
	)
	
	# Position it exactly where the tile was
	var world_pos = tilemap.map_to_local(tile_pos)
	falling_sprite.global_position = tilemap.to_global(world_pos)
	
	# Add to scene
	get_tree().current_scene.add_child(falling_sprite)
	
	# Animate: fade out + fall down
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(falling_sprite, "position:y", falling_sprite.position.y + 100, 0.6)
	tween.tween_property(falling_sprite, "modulate:a", 0.0, 0.6)  # Fade out
	
	# Delete sprite after animation
	tween.chain().tween_callback(falling_sprite.queue_free)

func spawn_particles(tilemap: TileMap, tile_pos: Vector2i):
	# Create simple particle effect
	var particles = CPUParticles2D.new()
	
	var world_pos = tilemap.map_to_local(tile_pos)
	particles.global_position = tilemap.to_global(world_pos)
	
	# Configure particles
	particles.emitting = true
	particles.one_shot = true
	particles.amount = 8
	particles.lifetime = 0.6
	particles.direction = Vector2(0, 1)  # Fall down
	particles.spread = 30
	particles.gravity = Vector2(0, 300)
	particles.initial_velocity_min = 50
	particles.initial_velocity_max = 100
	particles.scale_amount_min = 2
	particles.scale_amount_max = 4
	particles.color = Color(0.6, 0.4, 0.2)  # Brown dust
	
	get_tree().current_scene.add_child(particles)
	
	# Auto-delete after particles finish
	await get_tree().create_timer(1.0).timeout
	particles.queue_free()
