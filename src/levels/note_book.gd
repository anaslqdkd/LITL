extends Interactable

var book_instance = null
var book_scene = preload("res://src/levels/book_scene.tscn")
var note_instance = null
var current_scene = null
var player = null

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if not book_scene:
		return
	self.book_instance = book_scene.instantiate()
	self.book_instance.book = "book2"
	print(book_instance)
	book_instance.connect("page_changed", Callable(self, "_on_page_changed"))
	add_child(book_instance)
	var note_item = preload("res://src/inventory/items/note.tres")
	var note_scene = load("res://src/inventory/note.tscn")  
	if player.has_item(note_item):
		return

func _on_page_changed():
	# TODO: à faire proprement
	var note_scene = load("res://src/inventory/note.tscn")  
	var note_item = preload("res://src/inventory/items/note.tres")
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if note_scene:
		note_instance = note_scene.instantiate()
		add_child(note_instance)
