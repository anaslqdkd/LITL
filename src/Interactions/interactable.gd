extends CollisionObject3D
class_name Interactable

# script à ajouter sur des objets type staticbody etc
@export var prompt_message = "Interact"
signal interacted()
var library_instance = null

func _ready():
	library_instance = get_tree().current_scene

func interact():
	if not library_instance.is_interacting:
		library_instance.is_interacting = true
		interacted.emit()
	print("in interact function")

func end_interaction():
	library_instance.is_interacting = false
