extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_game.tscn")
	print("the start button was pressed")


func _on_options_button_pressed() -> void:
	print("the options button was pressed")


func _on_quit_button_pressed() -> void:
	print("the quit button was pressed")
	get_tree().quit()
