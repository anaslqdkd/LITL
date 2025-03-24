extends Control

@onready var inv: Inv = preload("res://src/inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


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

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()

func open():
	self.visible = true
	self.is_open = true

func close():
	self.visible = false
	self.is_open = false
