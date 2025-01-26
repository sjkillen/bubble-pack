extends Control
class_name Game

@export var ball_oob_time := 5.0 # Seconds a ball can stay out of bounds for 
@export var ball_radius_decay_ratio := 22.5
@export var tap_fuel_radius_ratio := .1
@export var tap_refuel_bonus := 1.5
@export var time_between_ticks := 1.0
@export var starting_radius := 0.05
@export var max_delay_ticks := 10
@export var max_target_size := 0.2
@export var size_curve: Curve
@export var flick_power := 5.0
@export var fuel_purity_tolerance := 0.8


@export var goal_color: Color
@export var goal_fill: float = 0.75

var is_running = false

@onready var taps: Array[Tap] = %Game.get_taps()

func _ready() -> void:
	switch_to_editor_view()
	taps[0].fuel_color = Color(1.0, 0.0, 0.0)
	taps[1].fuel_color = Color(0.0, 1.0, 0.0)
	taps[2].fuel_color = Color(0.0, 0.0, 1.0)

func emit_tick():
	taps[0].tick(%PoetryInterface.PoemA)
	taps[1].tick(%PoetryInterface.PoemB)
	taps[2].tick(%PoetryInterface.PoemC)
	

func create_ball() -> Ball:
	return %Game.create_ball()

func ball_decayed(ball: Ball):
	var ball_color := Util.color_to_vec3(ball.color)
	for tap in taps:
		var tap_color := Util.color_to_vec3(tap.fuel_color)
		var d := ball_color.distance_to(tap_color)
		if d <= fuel_purity_tolerance:
			# Ball ref may be invalidated after wait below, store radius now
			var radius := ball.radius
			ball.refuel_float_to(tap.refuel_pos())
			tap.refuel(radius * tap_fuel_radius_ratio * tap_refuel_bonus)
			return
	ball.harden()
	


func pause_game():
	if not is_running:
		return
	$Playback/VBoxContainer/Button.text = "Execute Poems"
	is_running = false

func unpause_game():
	if is_running:
		return
	$Playback/VBoxContainer/Button.text = "Pause Poems"
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
		

var editor_view: bool = true
func switch_to_editor_view():
	$Playback/VBoxContainer/Button2.text = "View Machine"
	$EditorView.visible = true
	$FullscreenBalls.visible = false
	$FullscreenBalls/SubViewportContainer3/SubViewport/Camera3D.current = false
	$EditorView/SubViewportContainer/SubViewport/Camera3D.current = true
	editor_view = true

func switch_to_machine_view():
	$Playback/VBoxContainer/Button2.text = "View Editor"
	$EditorView.visible = false
	$FullscreenBalls.visible = true
	$EditorView/SubViewportContainer/SubViewport/Camera3D.current = false
	$FullscreenBalls/SubViewportContainer3/SubViewport/Camera3D.current = true
	editor_view = false
	

func _on_button_2_pressed() -> void:
	if editor_view:
		switch_to_machine_view()
	else:
		switch_to_editor_view()
