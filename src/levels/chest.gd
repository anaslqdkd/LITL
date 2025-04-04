extends Interactable

var current_scene = null
var player = null

@export var item: InvItem
@export var chest_open_sound: AudioStreamPlayer
@export var pick_item_sound: AudioStreamPlayer
var key_instance: Area2D

var key_item = preload("res://src/inventory/items/key.tres")
@onready var animation_player = get_node("AnimationPlayer")
var magnifying_glass_instance: Area2D 
var magnifying_glass_scene = load("res://src/inventory/magnifying_glass.tscn")  
var magnifying_glass = preload("res://src/inventory/items/magnifying_glass.tres")

var is_open = false

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if magnifying_glass_scene:
		magnifying_glass_instance = magnifying_glass_scene.instantiate()
	if player.has_item(key_item):
		animation_player.play("open_chest")
		is_open = true
		NotificationPanel.send_notification("Chest unlocked")
		await get_tree().create_timer(1.5).timeout
		if not player.has_item(magnifying_glass):
			add_child(magnifying_glass_instance)
			end_interaction()
	else:
		NotificationPanel.send_notification("The chest is locked")
	if is_open:
		await get_tree().create_timer(2.5).timeout
		animation_player.play("close_chest")
	end_interaction()
