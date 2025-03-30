extends GridMap


var tween: Tween
var current_scene = null
var buttonDoor = null

func _ready() -> void:
	current_scene = get_tree().current_scene

func animate_wall_position():
	var final_position = Vector3(0, 0, 3)
	tween = create_tween() 
	tween.tween_property(self, "position", final_position, 3.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)


func _on_static_body_3d_move_door() -> void:
	animate_wall_position()
