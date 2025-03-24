extends Area2D

var current_scene = null
var player = null

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton: 
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed: 
			_on_sprite_clicked()

func _on_sprite_clicked(): 
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var key_item = preload("res://src/inventory/items/key.tres")
	player.collect(key_item)
	NotificationPanel.send_notification("key added to the inventory")
	queue_free()
