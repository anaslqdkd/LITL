extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://src/levels/library_1.tscn")


func _on_options_button_pressed() -> void:
	print("the options button was pressed")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
