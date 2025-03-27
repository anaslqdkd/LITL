extends Interactable

func _on_interacted() -> void:
	var current_scene = get_tree().current_scene  
	
	var light_node = current_scene.get_node_or_null("Light")
	if not light_node:
		print("Error: 'Light' node not found!")
		return
	
	for chandelier in light_node.get_children():
		var light = chandelier.get_node_or_null("OmniLight3D")
		if light.visible == true:
			light.visible = false  
			LightsState.lights_off = true
		else:
			light.visible = true
			LightsState.lights_off = false
	
	print("All chandelier lights turned off!")
