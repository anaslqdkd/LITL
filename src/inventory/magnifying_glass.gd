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
	var magnifying_glass = preload("res://src/inventory/items/magnifying_glass.tres")
	player.collect(magnifying_glass)
	NotificationPanel.send_notification("magnifying glass added to the inventory")
	queue_free()
