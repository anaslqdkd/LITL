extends Interactable

var book_instance = null
var book_scene = preload("res://src/levels/book_scene.tscn")
var note_instance = null
var current_scene = null
var player = null
var note_scene = preload("res://src/inventory/note.tscn")  
var note_item = preload("res://src/inventory/items/note.tres")



func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if not book_scene:
		return
	self.book_instance = book_scene.instantiate()
	self.book_instance.book = "the_great_gatsby"
	print(book_instance)
	book_instance.connect("page_changed", Callable(self, "_on_page_changed"))
	book_instance.connect("page_changed_2", Callable(self, "_on_page_changed_2"))
	book_instance.connect("animation_finished", Callable(self, "_on_animation_finished"))
	add_child(book_instance)
	if player.has_item(note_item):
		return

func _on_page_changed():
	if not player.has_item(note_item):
		current_scene = get_tree().current_scene
		player = current_scene.get_node_or_null("Player")
		if note_instance == null and note_scene:
			note_instance = note_scene.instantiate()
			note_instance.position.x = 500
			note_instance.position.y = 350

func _on_page_changed_2():
	if note_instance != null:
		note_instance.queue_free()
		note_instance = null

func _on_animation_finished():
	if note_instance:
		NotificationPanel.send_notification("Tip: you can click on an item to acquire it")
		current_scene.add_child(note_instance)
	return
