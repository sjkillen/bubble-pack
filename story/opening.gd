extends Node3D

func _ready() -> void:
	Dialogic.start(preload("opening_timeline.dtl"))
	await Dialogic.timeline_ended
	get_tree().change_scene_to_file("res://game_with_ui.tscn")
