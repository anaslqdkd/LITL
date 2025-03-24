extends Interactable

var book_instance = null
var book_scene = preload("res://src/levels/book_scene.tscn")
var note_instance: Area2D
var current_scene = null
var player = null

func _on_interacted() -> void:
	print("GAGAGAGAGAGAGGAGGGGGGGGGGGGGGGGGGG")
	# current_scene = get_tree().current_scene
	# player = current_scene.get_node_or_null("Player")
	# if not book_scene:
	# 	return
	# self.book_instance = book_scene.instantiate()
	# self.book_instance.book = "book2"
	# add_child(book_instance)
	# var note_item = preload("res://src/inventory/items/note.tres")
	# var note_scene = load("res://src/inventory/note.tscn")  
	# if note_scene:
	# 	print("the scene exists")
	# 	note_instance = note_scene.instantiate()
	# if player.has_item(note_item):
	# 	return
	# else:
	# 	add_child(note_instance)
