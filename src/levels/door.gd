extends Interactable


var keypad_instance = null

func _on_interacted() -> void:
	# par exemple
	if self.keypad_instance:
		return 
	var keypad_scene = load("res://src/Interactions/keypad/keypad.tscn")
	if not keypad_scene:
		print("Error: Failed to load keypad scene")

	self.keypad_instance = keypad_scene.instantiate()
	add_child(keypad_instance)
