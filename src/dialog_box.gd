extends MarginContainer

# TODO: fonction pour enlever de l'ecran, mapper une touche pour l'affichage, gestion des lignes de dialogue à voir

@onready var label = $MarginContainer/Label
@onready var timer = $Timer

const MAX_WIDTH = 300

var text = ""
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	# print("lfkjlsdkjlsk")
	text = text_to_display
	# label.text = text_to_display
	# await get_tree().process_frame
	print(size.x)
	print("in the display text function")
	global_position.x = size.x/2
	global_position.y = size.y + 24

	_display_letter()

func _display_letter():
	print("in display letter function")
	label.text += text[letter_index]

	letter_index += 1

	if letter_index >= text.length():
		finished_displaying.emit()
		# print("here in the finished signal emit")
		return
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

	custom_minimum_size.x = min(size.x, MAX_WIDTH)

	if label.size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = 100
		custom_minimum_size.x = size.x



func _on_timer_timeout() -> void:
	_display_letter()
