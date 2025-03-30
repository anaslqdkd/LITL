extends MeshInstance3D

@onready var hour_hand = $WatchHands/HoursHand
@onready var minute_hand = $WatchHands/MinuteHand
@onready var second_hand = $WatchHands/SecondsHand

@onready var second_completed: bool = false

var hour_degree: float = 0.0
var minute_degree: float = 0.0
var seconds_degree: float = 0.0

func _ready():
	var time_os = Time.get_datetime_dict_from_system()
	var hours = time_os["hour"]
	var minutes = time_os["minute"]
	var seconds = time_os["second"]
	
	hour_degree = (hours % 12) * 30 + (minutes / 60.0) * 30
	minute_degree = minutes * 6
	seconds_degree = seconds * 6
	
	update_hand_rotations()

func _process(delta: float) -> void:
	if seconds_degree >= 360:
		seconds_degree = 0
	if minute_degree >= 360:
		minute_degree = 0
	if hour_degree >= 360:
		hour_degree = 0

	update_hand_rotations()

	if not second_completed:
		second_completed = true
		await get_tree().create_timer(1.0).timeout
		increase_second()

func update_hand_rotations():
	second_hand.rotation.x = - deg_to_rad(seconds_degree)
	minute_hand.rotation.x = - deg_to_rad(minute_degree)
	hour_hand.rotation.x = - deg_to_rad(hour_degree)

func increase_second():
	seconds_degree += 6.0
	minute_degree += 0.1
	hour_degree += 0.0083
	second_completed = false
