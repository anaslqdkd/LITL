extends Interactable

func _on_interacted() -> void:
	var current_scene = get_tree().current_scene
	var light_node = current_scene.get_node_or_null("Light")
	if not light_node:
		print("Error: 'Light' node not found!")
		return
		
	LightsState.toggle_lights()
	for chandelier in light_node.get_children():
		var light = chandelier.get_node_or_null("OmniLight3D")
		if LightsState.lights_off:
			light.visible = false  
			tween_exposure(0.2,2.5)
		else:
			light.visible = true
			tween_exposure(1,1.5)
	
	print("All chandelier lights turned off!")


func tween_exposure(target_exposure: float, duration: float):
	var world_env = get_tree().current_scene.get_node_or_null("WorldEnvironment")
	if world_env and world_env.environment:
		var tween = create_tween()
		tween.tween_property(world_env.environment, "tonemap_exposure", target_exposure, duration)
