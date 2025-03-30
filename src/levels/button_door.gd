extends Interactable

var current_scene = null
var scrollable_wall = null
signal move_door

func _on_interacted() -> void:
	move_door.emit()
	end_interaction()
