extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var anim_player = $AnimationPlayer

func _ready():
	color_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	color_rect.visible = false
	anim_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		on_transition_finished.emit()
		anim_player.play("fade_out")
	elif anim_name == "fade_out":
		color_rect.visible = false
	

func transition():
	color_rect.visible = true
	anim_player.play("fade_in")
