extends AudioStreamPlayer

func _ready():
	print("=== MUSIC DEBUG ===")
	print("1. Stream exists: ", stream != null)
	print("2. Stream path: ", stream.resource_path if stream else "NO STREAM")
	print("3. Autoplay enabled: ", autoplay)
	print("4. Volume DB: ", volume_db)
	print("5. Is playing: ", playing)
	print("6. Bus: ", bus)
	
	if stream:
		print("7. Loop enabled: ", stream.loop)
		print("8. Stream class: ", stream.get_class())
		
		# Force play
		print("Attempting to play...")
		play()
		
		await get_tree().create_timer(1.0).timeout
		print("After 1 sec - Playing: ", playing)
		print("Playback position: ", get_playback_position())

func _process(delta):
	# Check every frame
	if not playing and stream:
		print("WARNING: Music stopped! Restarting...")
		play()
