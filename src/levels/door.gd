extends Interactable

var keypad_instance = null
@export var item: InvItem

var player = null
var current_scene = null

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	player.collect(item)
	if self.keypad_instance:
		return 
	var keypad_scene = load("res://src/Interactions/keypad/keypad.tscn")
	if not keypad_scene:
		print("Error: Failed to load keypad scene")

	self.keypad_instance = keypad_scene.instantiate()
	add_child(keypad_instance)


func _on_interaction_finished() -> void:
	if keypad_instance:
		keypad_instance.queue_free()
