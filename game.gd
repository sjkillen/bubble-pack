extends Node3D

func create_ball() -> Ball:
	var ball := preload("res://ball/ball.tscn").instantiate()
	%balls.add_child(ball)
	return ball
