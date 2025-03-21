extends Control

var current_page: int = 0

@onready var book_sprite = $BookSprite
@onready var right_page_text = $rightPageLabel
@onready var left_page_text = $leftPageLabel
@onready var prev_button = $ButtonPrev
@onready var next_button = $ButtonNext

var direction_right: bool = true

var forward_animations = [
	"first_page",
	"second_page",
	"third_page",
	"fourth_page",
	"last_page",
	"close_book",
	"return_book"
	]
var page_contents = [
	["", ""],
	["", "page3 content"],
	["page4 content", "page5 content"],
	["page6 content", "page7 content"],
	["page7 content", "page8 content"],
	["page9 content", ""],
	["", ""],
	]

func _ready() -> void:
	_update_buttons()
	book_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _clear_pages():
	right_page_text.visible = false
	left_page_text.visible = false

func _play_animation():
	_clear_pages()
	if self.direction_right:
		book_sprite.play(forward_animations[current_page])
	else:
		book_sprite.play_backwards(forward_animations[current_page])

func _on_button_next_pressed() -> void:
	if self.current_page >= 6:
		self.current_page = 0
	self.direction_right = true
	_play_animation()
	self.current_page += 1

func _on_button_prev_pressed() -> void:
	self.direction_right = false
	self.current_page -= 1
	_play_animation()

func _on_animation_finished():
	right_page_text.text = page_contents[current_page][1]
	left_page_text.text = page_contents[current_page][0]
	right_page_text.visible = true
	left_page_text.visible = true
	prev_button.visible = true

func _update_buttons():
	if current_page == 0:
		prev_button.visible = false
