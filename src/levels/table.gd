extends Interactable

var book_instance = null

@export var item: InvItem

var player = null
var current_scene = null

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	# player.collect()
	player = current_scene.get_node_or_null("Player")
	player.collect(item)
	var book_scene = load("res://src/levels/book_scene.tscn")
	if not book_scene:
		return
	self.book_instance = book_scene.instantiate()
	self.book_instance.book = "book1"
	add_child(book_instance)
	
