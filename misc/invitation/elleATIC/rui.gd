extends CharacterBody2D

# References to your UI elements
@onready var sprite = $Sprite2D
@onready var color_rect = $ColorRect
@onready var label = $Label

# Dialogue settings
var dialogues = []
var current_dialogue_index = 0
var is_typing = false
var is_dialogue_active = false
var current_text = ""
var char_index = 0
var typing_speed = 0.05

# Player reference
var player_in_range = false
var player_ref = null

func _ready():
	# Hide dialogue box initially
	color_rect.hide()
	label.hide()
	
	# Set up your dialogue sequence
	dialogues = [
		"Will you please be my Valentine? Press E for next sentence",
		"I tried making so many games!",
		"Knitting, Piano playing",
		"Then I found the art for this Hannah and the Ice Caves.",
		"And it reminded me of us playing it that day.",
		"There is no button here to respond yes...",
		"Or no...",
		"Let me know when you have finished the game...",
		"Oh and",
		"I love you princess.",
		"",
		"PS. You will have to go back to the homepage now.",
		"There is no end screen. :P " 
	]

func trigger_interaction():
	"""Called by player when pressing E"""
	if not is_dialogue_active:
		start_dialogue()
	elif is_typing:
		skip_typing()
	else:
		next_dialogue()

func start_dialogue():
	if dialogues.size() == 0:
		return
	
	is_dialogue_active = true
	current_dialogue_index = 0
	color_rect.show()
	label.show()
	display_current_dialogue()

func display_current_dialogue():
	if current_dialogue_index >= dialogues.size():
		end_dialogue()
		return
	
	current_text = dialogues[current_dialogue_index]
	char_index = 0
	label.text = ""
	is_typing = true
	type_text()

func type_text():
	var displayed_text = ""
	
	while is_typing and char_index < current_text.length():
		displayed_text += current_text[char_index]
		label.text = displayed_text
		char_index += 1
		
		# Check overflow
		if label.get_visible_line_count() > 0 and label.get_line_count() > label.get_visible_line_count():
			displayed_text = current_text[char_index - 1]
			label.text = displayed_text
		
		await get_tree().create_timer(typing_speed).timeout
	
	is_typing = false

func skip_typing():
	is_typing = false
	label.text = current_text

func next_dialogue():
	current_dialogue_index += 1
	display_current_dialogue()

func end_dialogue():
	is_dialogue_active = false
	color_rect.hide()
	label.hide()
	label.text = ""
	current_dialogue_index = 0

# Detection when player enters/exits range
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		player_ref = body
		body.set_nearby_npc(self)
		print("Player entered NPC range")

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		body.clear_nearby_npc(self)
		player_ref = null
		if is_dialogue_active:
			end_dialogue()
		print("Player left NPC range")
