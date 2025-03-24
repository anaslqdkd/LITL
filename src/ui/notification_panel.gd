extends Node

@onready var notification_label = $Label
@export var notification_sound: AudioStreamPlayer

func _ready() -> void:
	self.visible = false

func send_notification(message: String, duration: float = 3.0):
	# notification_sound.play()
	self.visible = true
	notification_label.text = message
	
	notification_label.visible = true
	await get_tree().create_timer(duration).timeout 
	self.visible = false 
	notification_label.visible = false
	
