extends Node

var dialog_box_scene = preload("res://src/dialog_box.tscn")
var dialog_box_instance: Control = null

func test():
	dialog_box_instance = dialog_box_scene.instantiate()	
	get_tree().current_scene.add_child(dialog_box_instance)
	dialog_box_instance.display_text("a fost odata ca niciodata o baba si un mosneag care au murit de mititei ")

	dialog_box_instance.finished_displaying.connect(_on_dialog_finished)

func _on_dialog_finished():
	print("Dialog finished displaying!")
	var timer = Timer.new()
	timer.wait_time = 5.0  
	timer.one_shot = true 
	timer.timeout.connect(_on_dialog_timeout)

	add_child(timer)  
	timer.start()
	# dialog_box_instance.queue_free()

func _on_dialog_timeout():
	print("2 seconds passed. Closing dialog.")
	dialog_box_instance.queue_free()  


