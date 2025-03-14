
extends Button

signal on_interact


func _on_pressed() -> void:
	print("the value of the text is", text)
	emit_signal("on_interact", text)
