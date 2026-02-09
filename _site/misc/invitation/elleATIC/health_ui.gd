extends HBoxContainer

var max_hearts = 5
var current_health = 5

func _ready():
	update_hearts(current_health)

func update_hearts(health: int):
	current_health = health
	
	# Update each heart's visibility/opacity
	var hearts = get_children()
	for i in hearts.size():
		if i < current_health:
			# Full heart
			hearts[i].modulate = Color(1, 1, 1, 1)
		else:
			# Empty/greyed out heart
			hearts[i].modulate = Color(0.2, 0.2, 0.2, 0.5)
