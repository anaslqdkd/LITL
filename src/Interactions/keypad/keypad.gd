extends Control

# TODO: all the keypad mechanism

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_button_interact(value):
	# TODO: something like child.connect("on_interact", self, "on_button_interact") in another function, for every child in children
	print("in button interact")
	print(value)
