extends Control

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		get_tree().change_scene_to_file("res://story/opening.tscn")
