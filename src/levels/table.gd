extends Interactable

var book_instance = null

func _on_interacted() -> void:
	var book_scene = load("res://src/levels/book_scene.tscn")
	if not book_scene:
		return
	self.book_instance = book_scene.instantiate()
	self.book_instance.book = "book1"
	add_child(book_instance)
	
	print("interacted with the table")
