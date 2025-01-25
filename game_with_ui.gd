extends Control
class_name Game

signal tick

@export var ball_oob_time := 3.0 # Seconds a ball can stay out of bounds for 
@export var ball_radius_decay_ratio = 10.0
@export var time_between_ticks = 3.0
@export var growth_rate := 0.1
@export var starting_radius = 0.05

@export var goal_color: Color
@export var goal_fill: float = 0.75

var is_running = false

func emit_tick():
	tick.emit()

func create_ball() -> Ball:
	return %Game.create_ball()

func ball_decayed(ball: Ball):
	ball.queue_free()

func pause_game():
	if not is_running:
		return
	$Playback/Button.text = "Execute Poems"
	is_running = false

func unpause_game():
	if is_running:
		return
	$Playback/Button.text = "Pause Poems"
	is_running = true
	$TickTimer.start(time_between_ticks)

func _on_button_pressed() -> void:
	if not is_running:
		unpause_game()
	else:
		pause_game()
		
