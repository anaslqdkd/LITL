extends Interactable

var current_scene = null
var player = null

@export var item: InvItem
@export var chest_open_sound: AudioStreamPlayer
@export var pick_item_sound: AudioStreamPlayer
var key_instance: Area2D

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var magnifying_glass = preload("res://src/inventory/items/magnifying_glass.tres")
	var key_item = preload("res://src/inventory/items/explosion.tres")
	var key_scene = load("res://src/inventory/key.tscn")  
	if key_scene:
		key_instance = key_scene.instantiate()
	if player.has_item(key_item):
		NotificationPanel.send_notification("Chest unlocked")
		if not player.has_item(magnifying_glass):
			add_child(key_instance)
	else:
		NotificationPanel.send_notification("The chest is locked")
	end_interaction()
	
