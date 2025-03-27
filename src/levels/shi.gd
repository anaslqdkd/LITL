extends Interactable

var paper_instance = null
var paper_scene = preload("res://src/levels/paper_scene.tscn")

func _on_interacted() -> void:
	if not paper_scene:
		return

	paper_instance = paper_scene.instantiate()
	if paper_instance.has_method("_ready") and "note" in paper_instance:
		paper_instance.note = "shi" 
	else:
		print("Error: 'note' property not found in paper_instance")
	
	add_child(paper_instance)
