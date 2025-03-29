extends Interactable

var book_instance = null
var book_scene = preload("res://src/levels/book_scene.tscn")
var current_scene = null
var player = null

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if not book_scene:
		return
	self.book_instance = book_scene.instantiate()
	self.book_instance.book = "a_void"
	add_child(book_instance)
