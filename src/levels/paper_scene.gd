extends Control
var current_scene = null
var player = null

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
	if Input.is_action_just_pressed("mouse_click_left"):
		_on_sprite_clicked()

func _on_sprite_clicked(): 
	current_scene = get_tree().current_scene
	player = current_scene.get_node_or_null("Player")
	var paper_note = preload("res://src/inventory/items/paper_note.tres")
	if not player.has_item(paper_note):
		player.collect(paper_note)
		NotificationPanel.send_notification("paper note added in the inventory")
	queue_free()

func _exit_tree():
	var dialog_instance = preload("res://src/Interactions/dialog_box.tscn").instantiate()
	dialog_instance.dialog_number = note
	get_tree().current_scene.add_child(dialog_instance)
