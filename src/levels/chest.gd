extends Interactable

var current_scene = null
var player = null


func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var apple_item = preload("res://src/inventory/items/explosion.tres")
	if player.has_item(apple_item):
		print("TAAAAAAAAAAAAAAAAAA")
	else:
		print("BYYYYYYYYYYYYYYYYQEEEEEEE")
	
