extends Control


@onready var grid_container = $numbers
@onready var code_label = $codeLabel
var correct_password = "1234"
var password = ""

signal on_keypad_press
signal on_correct_password
signal on_wrong_password


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in grid_container.get_children():
		if child.has_signal("on_interact"):
			child.connect("on_interact", Callable(self, "on_button_interact"))
	# FIXME: cf le fix me de _on_password_correct
	code_label.text = ""
	self.connect("on_correct_password", Callable(self, "_on_password_correct"))
	self.connect("on_wrong_password", Callable(self, "_on_password_wrong"))




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_button_interact(value):
	password += str(value)
	code_label.text += str(value)

	if password.length() == correct_password.length():
		if password == correct_password:
			emit_signal("on_correct_password", password)
		else:
			emit_signal("on_wrong_password", password)
	emit_signal("on_keypad_press", password)
	print("Password: " + password)

func _on_password_correct(password):
	#FIXME: à voir ce qui se passe lorsque la porte est ouverte
	code_label.text = "buu"
	print("the correct password was entered")
	self.queue_free()

func _on_password_wrong(password):
	self.password = ""
	code_label.text = ""

	print("incorrect password!")
