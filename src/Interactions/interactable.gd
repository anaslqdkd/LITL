extends CollisionObject3D
class_name Interactable

# script à ajouter sur des objets type staticbody etc
@export var prompt_message = "Interact"
signal interacted()


func interact():
	interacted.emit()
	# interacted.emit(body)
	print("in interact function")

