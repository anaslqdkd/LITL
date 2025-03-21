extends Control

var dialog: Array
var dialog_index = 0
var finished = false

var dialog_number: String

@onready var next_label = $labelNext

func _ready() -> void:
	_load_dialog_data()
	load_dialog()

func _load_dialog_data():
	var dialog_string = FileAccess.get_file_as_string("res://src/levels/data/dialog_data.json") 
	var dialog_as_list = JSON.parse_string(dialog_string)
	var exemple = dialog_as_list[dialog_number]["lines"]
	self.dialog = exemple

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.visible_ratio = 0
		var tween = create_tween()
		var duration = estimate_time_to_display(dialog[dialog_index])
		tween.tween_property($RichTextLabel, "visible_ratio", 1.0, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.finished.connect(func(): finished = true)
		# TODO: une fonction pour évaluer la durée en fonction de la longueur du texte
		if dialog_index == dialog.size() - 1:
			next_label.text = ""
	else:
		queue_free()
	dialog_index += 1

func estimate_time_to_display(text: String, time_per_letter: float = 0.05) -> float: 
	var num_letters = text.length()  
	var total_time = num_letters * time_per_letter
	return total_time
