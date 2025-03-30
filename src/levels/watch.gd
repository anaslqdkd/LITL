extends Node2D

@onready var hour_hand = $HourHand  
@onready var minute_hand = $MinuteHand  
@onready var second_hand = $SecondHand 

var clock_radius = 100  
var center = Vector2(400, 300)  
var hour_angle = 0.0  
var minute_angle = 0.0
var second_angle = 0.0

@onready var timer = $Timer

func _ready():
	var time_os = Time.get_datetime_dict_from_system() 
	print(time_os)
	set_time(time_os["hour"], time_os["minute"], time_os["second"])  
	timer.start()  

func set_time(hour: int, minute: int, second: int) -> void:
	hour_angle = (hour % 12) * 30 + (minute / 60) * 30  
	minute_angle = minute * 6  
	second_angle = second * 6 

	update_clock_hands()

func update_clock_hands():
	var hour_pos = get_hand_position(hour_angle)
	hour_hand.points = [center, hour_pos]

	var minute_pos = get_hand_position(minute_angle)
	minute_hand.points = [center, minute_pos]

	var second_pos = get_hand_position(second_angle)
	second_hand.points = [center, second_pos]

func get_hand_position(angle: float) -> Vector2:
	var radian = deg_to_rad(angle - 90)  # Convert angle to radians and adjust the starting point
	return center + Vector2(cos(radian), sin(radian)) * clock_radius

func _on_timer_timeout():
	var time = Time.get_datetime_dict_from_system()
	set_time(time["hour"], time["minute"], time["second"])
