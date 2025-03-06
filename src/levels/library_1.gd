extends Node3D

const scene_library = preload("res://src/levels/library_1.tscn")
const scene_level = preload("res://src/levels/level_1.tscn")

var level_tag = "library"

func _input(event):
	if event.is_action_pressed("ui_focus_next"): ### Actuellement TAB
		if level_tag == "library":
			go_to_scene("level_1", "level_1")
		else:
			go_to_scene("library", "library")

func go_to_scene(scene_tag, dest):
	var scene_to_load
	
	match scene_tag:
		"library":
			scene_to_load = scene_library
		"level_1":
			scene_to_load = scene_level
		
	if scene_to_load != null:
		LevelTransition.transition()
		await LevelTransition.on_transition_finished
		level_tag = dest
		get_tree().change_scene_to_packed(scene_to_load)
