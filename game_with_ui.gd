extends Control
class_name Game

@export var ball_oob_time := 3.0 # Seconds a ball can stay out of bounds for 
@export var ball_radius_decay_ratio = 10.0
@export var time_between_ticks = 5.0
@export var starting_radius = 0.05
@export var max_delay_ticks = 10
@export var max_target_size = 0.1

@export var goal_color: Color
@export var goal_fill: float = 0.75

var is_running = false

@onready var taps = %Game.get_taps()

func emit_tick():
	taps[0].tick(%PoetryInterface.PoemA)
	taps[1].tick(%PoetryInterface.PoemB)
	taps[2].tick(%PoetryInterface.PoemC)
	

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

func get_aggregate_color() -> Color:
	var balls: Array[Ball] = %Game.get_balls()
	var r := 0.0 
	var g := 0.0
	var b := 0.0
	for ball in balls:
		r += ball.color.r
		g += ball.color.g
		b += ball.color.b
	r /= balls.size()
	g /= balls.size()
	b /= balls.size()
	
	return Color(r, g, b)

func get_aggregate_fill() -> float:
	var sum := 0.0
	for ball in %Game.get_balls():
		sum += ball.radius
	return sum

func _on_button_pressed() -> void:
	if not is_running:
		unpause_game()
	else:
		pause_game()
		
