extends Control

@onready var inv: Inv = preload("res://src/inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var item_selection_sound = $AudioStreamPlayer

var selected_index = 0
var selected_slot = null

var key_instance: Area2D
var key_scene = preload("res://src/inventory/key.tscn")  
var note_instance: Area2D
var note_scene = preload("res://src/inventory/note.tscn")  
var magnifying_glass_instance: Area2D
var magnifying_glass_scene = preload("res://src/inventory/magnifying_glass.tscn")  

var is_open = false

func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	# close() 
	mouse_filter = MOUSE_FILTER_PASS
	open()

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
		if i == selected_index:
			slots[i].modulate = Color(1, 1, 0)
		else:
			slots[i].modulate = Color(1, 1, 1)

func _process(delta: float) -> void:
	# if Input.is_action_just_pressed("i"):
	if is_open:
		handle_navigation()
		handle_selection()
				# close()
			# else:
			# 	open()

func open():
	self.visible = true
	self.is_open = true

func close():
	self.visible = false
	self.is_open = false

func handle_navigation():
	if Input.is_action_just_pressed("move_right"):
		item_selection_sound.play()
		selected_index = (selected_index + 1)%inv.slots.size()
		update_slots()
	if Input.is_action_just_pressed("move_left"):
		item_selection_sound.play()
		selected_index = (selected_index - 1)%inv.slots.size()
		update_slots()

func handle_selection():
	if Input.is_action_just_pressed("ui_accept"):
		selected_slot = inv.slots[selected_index]
		print(selected_slot)
		print(selected_slot.item)
		use_item(selected_slot)

func use_item(slot):
	# print("the item name is", slot.item.name)
	if slot.item:
		if slot.item.name == "key":
			if key_scene:
				key_instance = key_scene.instantiate()
				add_child(key_instance)
		if slot.item.name == "note":
			if note_scene:
				note_instance = note_scene.instantiate()
				add_child(note_instance)
		if slot.item.name == "magnifying_glass":
			if magnifying_glass_scene:
				magnifying_glass_instance = magnifying_glass_scene.instantiate()
				add_child(magnifying_glass_instance)
		else:
			return
	else:
		return
