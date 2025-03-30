extends Area2D

var current_scene = null
var player = null

@onready var shadow_sprite = $Shadow_sprite
# var inspect_mode: bool = false
signal inspect_mode
var can_click: bool = true
var note = preload("res://src/inventory/items/note.tres")
var magn_glass = preload("res://src/inventory/magnifying_glass.tscn")


func _ready() -> void:
	# connect("paper_note", Callable(self, "_on_paper_note"))
	# var magn_glass_instance = magn_glass.instantiate()
	# magn_glass_instance.connect("paper_note", Callable(self, "_on_paper_note"))
	shadow_sprite.visible = false

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton: 
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed: 
			if can_click:
				_on_sprite_clicked()

func _process(delta: float) -> void:
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if player.has_item(note):
		can_click = false
		pass
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if area.name == "Magnifying_glass" and Input.is_action_just_pressed("mouse_click_left"):
			queue_free()

func _input(event):
	# TODO: à voir si je fais la même chose pour les autres 
	if Input.is_action_just_pressed("a"):
		queue_free()
	pass


	# if event.is_action_pressed("a"):
	# 	queue_free()


func _on_sprite_clicked(): 
	print(inspect_mode)
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var note = preload("res://src/inventory/items/note.tres")
	if not player.has_item(note):
		inspect_mode.emit()
		emit_signal("inspect_mode")
		player.collect(note)
	current_scene.is_in_inventory = false
	queue_free()
	can_click = false

func _on_mouse_entered() -> void:
	shadow_sprite.visible = true
	

func _on_mouse_exited() -> void:
	shadow_sprite.visible = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.

func _on_paper_note():
	print("here")
	queue_free()
