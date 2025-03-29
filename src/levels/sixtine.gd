extends MeshInstance3D

@export var texture_on: Texture
@export var texture_off: Texture 

func _ready():
	LightsState.lights_toggled.connect(_on_lights_toggled)
	_on_lights_toggled(LightsState.lights_off)  

func _on_lights_toggled(state: bool):
	print("Mesh received signal! Lights Off:", state)  # Debugging
	if mesh:
		var mat = mesh.surface_get_material(0)
		if mat and mat is StandardMaterial3D:
			var new_mat = mat.duplicate()
			new_mat.albedo_texture = texture_off if state else texture_on
			mesh.surface_set_material(0, new_mat)
