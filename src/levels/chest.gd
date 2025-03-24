extends Interactable

var current_scene = null
var player = null

@export var item: InvItem
@export var chest_open_sound: AudioStreamPlayer
@export var pick_item_sound: AudioStreamPlayer

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var magnifying_glass = preload("res://src/inventory/items/magnifying_glass.tres")
	var key = preload("res://src/inventory/items/explosion.tres")
	if player.has_item(key):
		NotificationPanel.send_notification("Chest unlocked")
		player.collect(magnifying_glass)
	else:
		NotificationPanel.send_notification("The chest is locked")
	
