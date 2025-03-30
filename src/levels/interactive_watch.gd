extends Interactable

#
var hour_degree: float = 0.0
var minute_degree: float = 0.0
var seconds_degree: float = 0.0

var target_time: Dictionary = {}  
var player_time: Dictionary = {} 
@onready var hour_hand = $WatchHands/HoursHand
@onready var minute_hand = $WatchHands/MinuteHand
@onready var second_hand = $WatchHands/SecondsHand

signal move_door



func set_target_time():
	var time_os = Time.get_datetime_dict_from_system()
	target_time = {
		"hour": time_os["hour"],
		"minute": time_os["minute"],
		"second": time_os["second"]
	}
#
var in_interaction = false

func _on_interacted() -> void:
	set_target_time()
	in_interaction = true

func set_clock_time(time_dict: Dictionary):
	hour_degree = (time_dict["hour"] % 12) * 30 + (time_dict["minute"] / 60.0) * 30
	minute_degree = time_dict["minute"] * 6
	seconds_degree = time_dict["second"] * 6
	update_hand_rotations()

func update_hand_rotations():
	second_hand.rotation.x = -deg_to_rad(seconds_degree)
	minute_hand.rotation.x = -deg_to_rad(minute_degree)
	hour_hand.rotation.x = -deg_to_rad(hour_degree)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and in_interaction:
		increase_time_by_10_seconds()
func increase_time_by_10_seconds(): 
	if !player_time.has("second"):
		player_time["second"] = 0 
		if !player_time.has("minute"): 
			player_time["minute"] = 0 
			if !player_time.has("hour"): 
				player_time["hour"] = 0
	player_time["minute"] += 60
	if player_time["second"] >= 60:
		player_time["second"] -= 60
		player_time["minute"] += 1

	if player_time["minute"] >= 60:
		player_time["minute"] -= 60
		player_time["hour"] += 1

	if player_time["hour"] >= 12:
		player_time["hour"] -= 12

	set_clock_time(player_time)

	check_time()

func check_time():
	if player_time["hour"] == target_time["hour"] : 
		print("Correct time set!")
		move_door.emit()
		end_interaction()
