extends Control


func _on_resume_button_pressed() -> void:
	var current_scene = get_tree().current_scene
	current_scene.is_interacting = false
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		queue_free()
