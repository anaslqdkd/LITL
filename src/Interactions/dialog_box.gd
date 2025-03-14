extends Control

var dialog = [ 
	'A fost odata ca niciodata o baba si un mosneag care au murit de mititei',
	'Ei au trait fericiti pana la adanci batraneti',
	'Dar eu nu xd'
	]

var dialog_index = 0
var finished = false

@onready var next_label = $labelNext

func _ready() -> void:
	load_dialog()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.visible_ratio = 0
		var tween = create_tween()
		tween.tween_property($RichTextLabel, "visible_ratio", 1.0, 2.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		tween.finished.connect(func(): finished = true)
		# TODO: une fonction pour évaluer la durée en fonction de la longueur du texte
		if dialog_index == dialog.size() - 1:
			next_label.text = ""


	else:
		queue_free()
	dialog_index += 1
