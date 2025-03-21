extends Control

var current_page: int = 0

@onready var book_sprite = $BookSprite
@onready var right_page_text = $rightPageLabel
@onready var left_page_text = $leftPageLabel
@onready var prev_button = $ButtonPrev
@onready var next_button = $ButtonNext

func _ready() -> void:
	right_page_text.visible = false
	left_page_text.visible = false
	prev_button.visible = false
	book_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _clear_pages():
	right_page_text.visible = false
	left_page_text.visible = false

func _play_animation():
	# TODO: switch the text
	if current_page == 0:
		book_sprite.play("first_page")
		return
	if current_page == 1:
		_clear_pages()
		book_sprite.play("second_page")
		return 
	if current_page == 2:
		_clear_pages()
		book_sprite.play("third_page")
		return 
	if current_page == 3:
		_clear_pages()
		book_sprite.play("fourth_page")
		return 
	if current_page == 4:
		_clear_pages()
		book_sprite.play("last_page")
		return 
	if current_page == 5:
		_clear_pages()
		book_sprite.play("close_book")
		return 

func _on_button_next_pressed() -> void:
	_play_animation()
	self.current_page += 1


func _on_button_prev_pressed() -> void:
	# TODO: play the backwards animation
	pass # Replace with function body.

func _on_animation_finished():
	right_page_text.visible = true
	# première page donc texte que sur la gauche
	if current_page != 1 :
		left_page_text.visible = true
	if current_page in range(1, 5):
		prev_button.visible = true

	# dernière page donc texte que sur la gauche
	if current_page == 5:
		right_page_text.visible = false
	# on ferme le livre
	if current_page == 6:
		next_button.visible = false
		_clear_pages()
