extends Node3D

func create_ball() -> Ball:
	var ball := preload("res://ball/ball.tscn").instantiate()
	%balls.add_child(ball)
	return ball

func get_balls() -> Array:
	return %balls.get_children()

func get_taps() -> Array[Tap]:
	return %walls.get_taps()
