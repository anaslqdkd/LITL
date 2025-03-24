extends Control


@onready var grid_container = $numbers
@onready var code_label = $codeLabel
var correct_password = "1234"
var password = ""

signal on_keypad_press
signal on_correct_password
signal on_wrong_password

@onready var submit_button = $numbers/submitButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in grid_container.get_children():
		if child.has_signal("on_interact"):
			child.connect("on_interact", Callable(self, "on_button_interact"))
	# FIXME: cf le fix me de _on_password_correct
	code_label.text = ""
	self.connect("on_correct_password", Callable(self, "_on_password_correct"))
	self.connect("on_wrong_password", Callable(self, "_on_password_wrong"))
	submit_button.connect("pressed", Callable(self, "_on_submit_button_pressed"))




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_button_interact(value):
	if value in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]:
		password += str(value)
		code_label.text += str(value)
	if value == "non":
		if password.length() > 0:
			password = password.substr(0, password.length() - 1)
			code_label.text = code_label.text.substr(0, code_label.text.length() - 1)

	emit_signal("on_keypad_press", password)
	print("Password: " + password)

func _on_password_correct(password):
	#FIXME: à voir ce qui se passe lorsque la porte est ouverte
	code_label.text = "access granted!"
	print("the correct password was entered")
	var current_scene = get_tree().current_scene 
	current_scene.is_interacting = false
	self.queue_free()

func _on_password_wrong(password):
	self.password = ""
	code_label.text = ""
	print("incorrect password!")

func _on_submit_button_pressed():
	if password == correct_password:
		emit_signal("on_correct_password", password)
	else:
		emit_signal("on_wrong_password", password)
	print("the button submit was pressed")
