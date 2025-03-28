extends Area2D

var current_scene = null
var player = null
var dragging = false

var note_area: Area2D

@onready var shadow_sprite = $Shadow_sprite
var offset = Vector2()

@onready var collision_shape = $CollisionPolygon2D
signal dragsignal
var note_instance
var note_scene = preload("res://src/inventory/note.tscn")
var can_click: bool = true
var magn_glass = preload("res://src/inventory/items/magnifying_glass.tres")
signal paper_note

# func _input_event(viewport, event, shape_idx) -> void:
# 	if event is InputEventMouseButton: 
# 		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed: 
# 			if can_click:
# 				_on_sprite_clicked()

var overlapping_areas
var paper_scene
var paper_instance

func _ready() -> void:
	# note_instance = note_scene.instantiate()
	shadow_sprite.visible = false
	connect("dragsignal", Callable(self, "_set_drag_pc"))
	connect("paper_note", Callable(self, "_on_paper_note"))
	# connect("papernote", Callable(self, "_set_drag_pc"))
	# note_scene = load("res://src/inventory/note.tscn")  
	paper_scene = load("res://src/levels/paper_scene.tscn")  
	paper_instance = paper_scene.instantiate()
	note_instance = note_scene.instantiate()


func _process(delta):
	# TODO: à continuer
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)
	overlapping_areas = get_overlapping_areas()
	# for area in overlapping_areas:
	# 	if area.name == "Note":
	# 		var paper_scene = load("res://src/levels/paper_scene.tscn")  
	# 		var paper_instance = paper_scene.instantiate()
	# 		paper_instance.note = "note" 
	# 		add_child(paper_instance)
	# if Input.is_action_just_pressed("mouse_left_click"):
	# var overlapping_areas = get_overlapping_areas()
	
	for area in overlapping_areas:
		if area.name == "Note":
			var paper_note_item = load("res://src/inventory/items/paper_note.tres")
			paper_instance.note = "note"
			paper_note.emit()
			emit_signal("paper_note")
			if Input.is_action_just_pressed("mouse_click_left") and not player.has_item(paper_note_item):
				# add_child(paper_instance)
				current_scene.add_child(paper_instance)
				# paper_note.emit()
				# emit_signal("paper_note")
				# TODO: texture à changer dans l'inventaire pour la paper note
				player.collect(paper_note_item)
				# paper_instance.queue_free()

				# note_instance.kill()
				queue_free()
				# FIXME: player.collect(paper_instance)
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	if player.has_item(magn_glass):
		can_click = false
	



func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if not can_click:
				emit_signal("dragsignal")
			else:
				_on_sprite_clicked()
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")


func _set_drag_pc():
	dragging=!dragging

func _on_sprite_clicked(): 
	var magnifying_glass = preload("res://src/inventory/items/magnifying_glass.tres")
	if not player.has_item(magnifying_glass):
		current_scene = get_tree().current_scene
		player = current_scene.get_node_or_null("Player")
		player.collect(magnifying_glass)
		NotificationPanel.send_notification("magnifying glass added to the inventory")
		queue_free()

func _on_mouse_entered() -> void:
	shadow_sprite.visible = true
	

func _on_mouse_exited() -> void:
	shadow_sprite.visible = false

# func _on_paper_note() -> void:
# 	pass
