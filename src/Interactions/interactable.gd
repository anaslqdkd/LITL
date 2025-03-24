extends CollisionObject3D
class_name Interactable

# script à ajouter sur des objets type staticbody etc
@export var prompt_message = "Interact"
signal interacted()
var library_instance = null
signal interaction_finished()

func _ready():
	library_instance = get_tree().current_scene
	# print("the name of the library instance", library_instance.name)

func interact():
	if not library_instance.is_interacting:
		library_instance.is_interacting = true
		interacted.emit()
	# print("in interact function")

func end_interaction():
	interaction_finished.emit()
	library_instance.is_interacting = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		end_interaction()
