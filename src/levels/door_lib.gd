extends Interactable

var keypad_instance = null
@export var item: InvItem
var scene_final = load("res://src/levels/level1.tscn")
var player = null
var current_scene = null

func _on_interacted() -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	player.collect(item)
	go_to_library()
	
func go_to_library():
	LevelTransition.transition()
	await LevelTransition.on_transition_finished
	print("Transition finished, changing scene now!")
	call_deferred("_change_scene")

func _change_scene():
	if scene_final:
		get_tree().change_scene_to_packed(scene_final)
	else:
		print("Error: Scene not loaded properly!")
