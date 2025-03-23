extends Interactable


var keypad_instance = null
@export var item: InvItem

var player = null
var current_scene = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_on_keypad_closed()

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	player.collect(item)
	player.set_movement(false)
	if self.keypad_instance:
		return 
	var keypad_scene = load("res://src/Interactions/keypad/keypad.tscn")
	if not keypad_scene:
		print("Error: Failed to load keypad scene")

	self.keypad_instance = keypad_scene.instantiate()
	add_child(keypad_instance)

func _on_keypad_closed():
	current_scene = get_tree().current_scene 
	player = current_scene.get_node_or_null("Player") 
	if keypad_instance:
		keypad_instance.queue_free()
	player.set_movement(true)
