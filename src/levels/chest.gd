extends Interactable

var current_scene = null
var player = null

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass

func _on_interacted() -> void:
	pass
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var apple_item = preload("res://src/inventory/items/explosion.tres")
	if player.has_item(apple_item):
		print("TAAAAAAAAAAAAAAAAAA")
	else:
		print("BYYYYYYYYYYYYYYYYQEEEEEEE")
	
