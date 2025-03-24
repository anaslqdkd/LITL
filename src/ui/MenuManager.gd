extends Node

var menu: PackedScene
var menu_instance: Control

func _ready():
	menu = load("res://src/ui/pause_menu.tscn")

func show():
	var current_scene = get_tree().current_scene
	# print("the current scene is in show", current_scene.name)
	if menu:
		if not menu_instance:
			menu_instance = menu.instantiate()
			current_scene.add_child(menu_instance)

func close():
	if menu_instance:
		menu_instance.queue_free()
