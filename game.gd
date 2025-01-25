extends Node3D


func _ready() -> void:
	GameGlobal.spawn_ball.connect(spawn_ball)

func spawn_ball(radius: float, color: Color):
	var ball := preload("res://ball/ball.tscn").instantiate()
	ball.radius = radius
	ball.color = color
	%balls.add_child(ball)
	$chute.spawn(ball)
