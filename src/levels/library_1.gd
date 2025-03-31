extends Node3D

var is_interacting: bool = false
var is_in_inventory: bool = false

func _ready() -> void:
	_load_dialog_box()

func _input(event):
	if event.is_action_pressed("ui_text_delete"): 
		_load_dialog_box()
	if event.is_action_pressed("ui_cancel") and not is_interacting and not is_in_inventory: 
		open_menu()

func open_menu():
	self.is_interacting = true 
	MenuManager.show()

func _load_dialog_box():
	var dialog_box_scene = load("res://src/Interactions/dialog_box.tscn")
	if not dialog_box_scene:
		print("Error: Failed to load dialog scene")
		return 
	var dialog_box_instance = dialog_box_scene.instantiate()
	dialog_box_instance.dialog_number = "Begin"
	add_child(dialog_box_instance)


func _on_interacted() -> void:
	pass # Replace with function body.
