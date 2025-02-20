extends Node

var dialog_box_scene = preload("res://src/dialog_box.tscn")
var dialog_box_instance: Control = null

func test():
	dialog_box_instance = dialog_box_scene.instantiate()	
	get_tree().current_scene.add_child(dialog_box_instance)
	dialog_box_instance.display_text("a fost odata ca niciodata o baba si un mosneag care au murit de mititei ")
