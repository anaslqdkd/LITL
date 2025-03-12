extends Interactable


func _on_interacted() -> void:
	# par exemple
	get_parent().visible = false
	print("buuu")
