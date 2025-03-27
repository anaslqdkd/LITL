extends RayCast3D

@onready var prompt = $Prompt

func _physics_process(delta: float) -> void:
	prompt.text = ""
	if is_colliding():
		var hit_object = get_collider()
		if hit_object and hit_object is Interactable:
			prompt.text = "press [E] to interact"
			if Input.is_action_just_pressed("interact"):
				hit_object.interact()
		else:
			if hit_object:
				prompt.text = ""
