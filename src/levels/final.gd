extends Node  # Or the appropriate node type

@onready var anim_player = $cam_rig/AnimationPlayer

func _ready():
	anim_player.play("Final_Cutscene")  # Replace with the actual animation name
	anim_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: String):
	if anim_name == "Final_Cutscene":  # Ensure it only triggers for the right animation
		get_tree().change_scene_to_file("res://src/main_menu.tscn")  # Update the path
