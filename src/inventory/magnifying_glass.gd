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
var note_scene
# func _input_event(viewport, event, shape_idx) -> void:
# 	if event is InputEventMouseButton: 
# 		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed: 
# 			_on_sprite_clicked()
var overlapping_areas

func _ready() -> void:
	shadow_sprite.visible = false
	connect("dragsignal", Callable(self, "_set_drag_pc"))
	# note_scene = load("res://src/inventory/note.tscn")  


func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)
	overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if area.name == "Note":
			# TODO: à mettre la bonne scène à afficher
			var key_scene = load("res://src/inventory/key.tscn")  
			var key_instance = key_scene.instantiate()
			add_child(key_instance)



func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()


func _set_drag_pc():
	dragging=!dragging

func _on_sprite_clicked(): 
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var magnifying_glass = preload("res://src/inventory/items/magnifying_glass.tres")
	if not player.has_item(magnifying_glass):
		player.collect(magnifying_glass)
		NotificationPanel.send_notification("magnifying glass added to the inventory")
		queue_free()

func _on_mouse_entered() -> void:
	shadow_sprite.visible = true
	

func _on_mouse_exited() -> void:
	shadow_sprite.visible = false
