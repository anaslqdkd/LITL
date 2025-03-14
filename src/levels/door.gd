extends Interactable


func _on_interacted() -> void:
	# par exemple
	var keypad_scene = load("res://src/Interactions/keypad/keypad.tscn")
	if not keypad_scene:
		print("Error: Failed to load keypad scene")

	var keypad_instance = keypad_scene.instantiate()
	add_child(keypad_instance)
