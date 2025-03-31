extends Interactable

var book_instance = null
var book_scene = preload("res://src/levels/book_scene.tscn")
var key_instance: Area2D
var current_scene = null
var player = null

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if not book_scene:
		return
	self.book_instance = book_scene.instantiate()
	self.book_instance.book = "wuthering_heights"
	add_child(book_instance)
	var key_item = preload("res://src/inventory/items/key.tres")
	var key_scene = load("res://src/inventory/key.tscn")  
	if key_scene:
		key_instance = key_scene.instantiate()
	if player.has_item(key_item):
		return
	else:
		NotificationPanel.send_notification("Tip: you can click on an item to acquire it")
		add_child(key_instance)
