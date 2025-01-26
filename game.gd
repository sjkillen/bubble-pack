extends Node3D

func create_ball() -> Ball:
	var ball := preload("res://ball/ball.tscn").instantiate()
	%balls.add_child(ball)
	return ball

func get_balls() -> Array[Ball]:
	return %balls.get_children() as Array[Ball]

func get_taps() -> Array[Tap]:
	return %walls.get_taps()
