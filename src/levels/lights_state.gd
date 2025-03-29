extends Node

signal lights_toggled(state: bool)

var lights_off: bool = false

func toggle_lights():
	lights_off = !lights_off
	print("Light toggled, state is now:", lights_off)
	lights_toggled.emit(lights_off) 
