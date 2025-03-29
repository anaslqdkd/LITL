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
			
		else:
			light.visible = true
	
	print("All chandelier lights turned off!")
