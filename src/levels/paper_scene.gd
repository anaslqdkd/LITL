extends Control

@onready var text = $TextLabel

var note: String = ""

func _ready() -> void:
	_load_note() 

func _load_note():
	var note_string = FileAccess.get_file_as_string("res://src/levels/data/notes_data.json")
	var note_as_dict = JSON.parse_string(note_string)

	if note in note_as_dict:
		var note_content = note_as_dict[note]
		if note_content is Array and note_content.size() > 0:
			text.text = note_content[0]
		else:
			text.text = "Error: Note format invalid."
	else:
		text.text = "Error: Note not found."

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
