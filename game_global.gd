extends Node

signal spawn_ball(radius: float, color: Color)

# Number of seconds a ball has to stay unmoving in the OOB zone
@export var ball_oob_time: float = 3.0



# Useless function to suppress editor warnings
func __use_signals():
	spawn_ball.emit()
