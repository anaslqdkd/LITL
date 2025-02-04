extends CharacterBody3D

@export var speed: float = 4.0  # Vitesse de déplacement
@export var sprite_3d: Sprite3D  # Référence au sprite

func _physics_process(delta):
	var direction = Vector3.ZERO

	# Récupération des entrées clavier
	if Input.is_action_pressed("move_right"):
		direction.x += speed
	elif Input.is_action_pressed("move_left"):
		direction.x -= speed
	elif Input.is_action_pressed("move_up"):
		direction.z -= speed
	elif Input.is_action_pressed("move_down"):
		direction.z += speed

	# Normalisation pour éviter d'aller plus vite en diagonale
	#direction = direction.normalized()

	# Appliquer le mouvement
	velocity = direction * speed
	move_and_slide()
