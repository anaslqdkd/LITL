extends CharacterBody3D
@onready var animation = $AnimatedSprite3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const IDLE_DELAY = 0.2

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var last_direction = "left"

@export var inv: Inv

var can_move = true

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		# print("not on the floor")
		velocity.y -= gravity*delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction and can_move:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		if abs(direction.x) > abs(direction.z):
			if direction.x > 0:
				animation.play("walk_right")
				last_direction = "right"
			else:
				animation.play("walk_left")
				last_direction = "left"
		else:
			if direction.z > 0:
				animation.play("walk_front")
				last_direction = "front"
			else:
				animation.play("walk_back")
				last_direction = "back"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if animation.get_animation().begins_with("walk"):
			await get_tree().create_timer(IDLE_DELAY).timeout
			animation.play("idle_" + last_direction)
			
	if can_move:
		move_and_slide()


func collect(item):
	inv.insert(item)

func has_item(item) -> bool:
	for slot in inv.slots:
		if slot.item == item:
			return true
	return false

func _process(delta: float) -> void:
	var current_scene = get_tree().current_scene
	var player = current_scene.get_node_or_null("Player")
	if current_scene.is_interacting:
		player.can_move = false
	else:
		player.can_move = true
