extends Interactable

var book_instance = null
# var book_scene = load("res://src/levels/book_scene.tscn")
var book_scene = null

func _ready():
	self.book_scene = load("res://src/levels/book_scene.tscn")

func _on_interacted() -> void:
	if not book_scene:
		return
	self.book_instance = book_scene.instantiate()
	self.book_instance.book = "book2"
	add_child(book_instance)
