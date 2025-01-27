extends Control

func _ready() -> void:
	var vbox = $VBoxContainer
	vbox.set_size( Vector2(200, 200), false)

func _on_start_button_pressed() -> void:
	print("the start button was pressed")


func _on_options_button_pressed() -> void:
	print("the options button was pressed")


func _on_quit_button_pressed() -> void:
	print("the quit button was pressed")
	get_tree().quit()
