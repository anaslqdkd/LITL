extends InteractableButtons

signal on_interact
var number = 0

func interact():
	emit_signal("on_interact", number)
	print("here")


func _on_pressed() -> void:
	interact()
