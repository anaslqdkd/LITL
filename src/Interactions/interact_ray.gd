extends RayCast3D

@onready var prompt = $Prompt

func _physics_process(delta: float) -> void:
	prompt.text = ""
	if is_colliding():
		var hit_object = get_collider()
		if hit_object and hit_object is Interactable:
			prompt.text = "detecting" + get_collider().prompt_message
		else:
			if hit_object:
				prompt.text = "detecting not interactable"
