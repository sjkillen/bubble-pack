extends Node3D
class_name Game

signal tick

@export var ball_oob_time := 3.0 # Seconds a ball can stay out of bounds for 
@export var ball_radius_decay_ratio = 10.0
@export var time_between_ticks = 3.0
@export var growth_rate := 0.1
@export var starting_radius = 0.05

@export var goal_color: Color
@export var goal_fill: float = 0.75

func emit_tick():
	tick.emit()

func create_ball() -> Ball:
	var ball := preload("res://ball/ball.tscn").instantiate()
	%balls.add_child(ball)
	return ball

func ball_decayed(ball: Ball):
	ball.queue_free()
