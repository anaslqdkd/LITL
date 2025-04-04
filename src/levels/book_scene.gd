extends Control

var current_page: int = 0

@onready var book_sprite = $BookSprite
@onready var right_page_text = $rightPageLabel
@onready var left_page_text = $leftPageLabel
@onready var prev_button = $ButtonPrev
@onready var next_button = $ButtonNext
@onready var turn_page_sound = $AudioStreamPlayer

var direction_right: bool = true
var note_instance = null
var current_scene = null
var player = null

var book: String
var pages_number: int
var ecart: int

var forward_animations = [
	"first_page",
	"second_page",
	"third_page",
	"fourth_page",
	"last_page",
	"close_book",
	"return_book"
	]

var page_contents: Array
signal page_changed
signal page_turned
signal page_changed_2
signal animation_finished

func _load_books_data():
	var books_string = FileAccess.get_file_as_string("res://src/levels/data/books_data.json") 
	var books_as_dict = JSON.parse_string(books_string)
	var exemple = books_as_dict[self.book]["pages"]
	self.page_contents = exemple
	self.pages_number = self.page_contents.size() - 1
	print("the size of the self.page_contents is", self.page_contents.size())


func _ready() -> void:
	ecart = pages_number - 7
	_update_buttons()
	_load_books_data()
	book_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))
	connect("page_changed", Callable(self, "_on_page_changed"))
	connect("page_turned", Callable(self, "_on_page_turned"))
	connect("page_changed_2", Callable(self, "_on_page_changed_2"))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
	if self.current_page == 2:
		emit_signal("page_changed")
		page_changed.emit()
	if self.current_page != 2:
		emit_signal("page_changed_2")
		page_changed_2.emit()


func _clear_pages():
	right_page_text.visible = false
	left_page_text.visible = false

func _play_animation():
	_clear_pages()
	if self.direction_right:
		if current_page >= 0 and current_page <= 1:
			book_sprite.play(forward_animations[current_page])
		elif current_page == pages_number - 1:
			book_sprite.play(forward_animations[4])
		elif current_page == pages_number:
			book_sprite.play(forward_animations[5])
		elif current_page == pages_number + 1:
			book_sprite.play(forward_animations[6])

		elif current_page >= 2 and current_page <= pages_number - 2:
			book_sprite.play(forward_animations[2])
	else:
		if current_page >= 0 and current_page <= 1:
			book_sprite.play_backwards(forward_animations[current_page]) 
		elif current_page == pages_number - 1:
			book_sprite.play_backwards(forward_animations[4]) 
		elif current_page == pages_number:
			book_sprite.play_backwards(forward_animations[5]) 
		elif current_page == pages_number + 1:
			book_sprite.play_backwards(forward_animations[6]) 
		elif current_page >= 2 and current_page <= pages_number - 2:
			book_sprite.play_backwards(forward_animations[2])
	emit_signal("page_turned")

func _on_button_next_pressed() -> void:

	if self.current_page >= pages_number:
		self.current_page = 0
	self.direction_right = true
	_play_animation()
	self.current_page += 1

func _on_button_prev_pressed() -> void:
	self.direction_right = false
	self.current_page -= 1
	_play_animation()

func _on_animation_finished():
	emit_signal("animation_finished")
	animation_finished.emit()
	right_page_text.text = page_contents[current_page][1]
	left_page_text.text = page_contents[current_page][0]
	right_page_text.visible = true
	left_page_text.visible = true
	prev_button.visible = true

func _update_buttons():
	if current_page == 0:
		prev_button.visible = false

func _exit_tree():
	var dialog_instance = preload("res://src/Interactions/dialog_box.tscn").instantiate()
	dialog_instance.dialog_number = book
	get_tree().current_scene.add_child(dialog_instance)

func _on_page_turned():
	turn_page_sound.play()
	# pass
