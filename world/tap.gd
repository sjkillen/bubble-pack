extends Node3D
class_name Tap

@export var neighbour: Tap
@export var fuel_color: Color
@export var create_color: Color = Color.WHITE
var held_ball: Ball = null
var fuel_amount: float = 0.0 # 0 to 1

enum State {
	Stalled,
	Empty,
	Growing,
	Holding,
}
@export var state: State = State.Empty


@onready var game := Util.find_game_parent(self)

@onready var shader_fuel_amount: float = fuel_amount
var shader_fuel_tween: Tween = null
@onready var shader_create_color: Color = create_color
var shader_create_color_tween: Tween = null

func _process(_delta: float) -> void:
	$Tap.set_instance_shader_parameter("fuel_amount", shader_fuel_amount)
	$Tap.set_instance_shader_parameter("fuel_color", fuel_color)
	$Tap.set_instance_shader_parameter("create_color", shader_create_color)

var delay_ticks := 0
var current_line: Variant = null
var target_size := 0.0
var line_parameters = null

func tick(poem: Poem):
	if state == State.Holding:
		delay_ticks -= 1
		if delay_ticks <= 0:
			command_release_ball()
		return
	if state == State.Empty or state == State.Stalled:
		if state == State.Empty:
			current_line = poem.next()
			line_parameters = current_line.parameterize()
			if not line_parameters:
				return
		state = State.Stalled
		if not consume_fuel(line_parameters["size"]):
			return
		delay_ticks = int(line_parameters["delay"] * game.max_delay_ticks)
		var size_scale := game.size_curve.sample(line_parameters["size"])
		target_size = size_scale * game.max_target_size
		command_set_color(Color.from_string(line_parameters["color"], Color.WHITE))
		command_create_ball()
		held_ball.grow_ball(target_size)
	else:
		command_stop_growing()
	
func consume_fuel(radius: float) -> bool:
	var fuel_used := game.tap_fuel_radius_ratio * radius
	if fuel_amount < fuel_used:
		$AnimationPlayer.play("BakedNoFuel")
		return false
	fuel_amount = clampf(fuel_amount-fuel_used, 0.0, 1.0)
	if shader_fuel_tween != null:
		shader_fuel_tween.kill()
	shader_fuel_tween = create_tween()
	shader_fuel_tween.tween_property(self, "shader_fuel_amount", fuel_amount, game.time_between_ticks)
	return true

func create_ball():
	if held_ball != null:
		push_error("Already a ball being created?")
		return
	var ball := game.create_ball()
	ball.global_position = $SpawnMarker.global_position
	ball.color = create_color
	ball.radius = game.starting_radius
	held_ball = ball
	
func command_create_ball():
	if state != State.Empty and  state != State.Stalled:
		push_error("Tap is not empty!")
		return
	create_ball()
	state = State.Growing

func command_set_color(color: Color):
	create_color = color
	if shader_create_color_tween != null:
		shader_create_color_tween.kill()
	shader_create_color_tween = create_tween()
	shader_create_color_tween.tween_property(self, "shader_create_color", create_color, game.time_between_ticks)
	await shader_create_color_tween.finished
	shader_create_color_tween = null

func command_stop_growing():
	if state != State.Growing:
		push_error("Tap is not growing!")
		return
	state = State.Holding
	
func command_release_ball():
	if state != State.Holding:
		push_error("Tap is not holding a ball!")
		return
	state = State.Empty
	held_ball.release_ball()
	held_ball = null

func refuel(add_amount: float):
	$AnimationPlayer.play("RefuelKey")
	fuel_amount = clampf(fuel_amount+add_amount, 0.0, 1.0)
	if shader_fuel_tween != null:
		shader_fuel_tween.kill()
	shader_fuel_tween = create_tween()
	shader_fuel_tween.tween_property(self, "shader_fuel_amount", fuel_amount, game.time_between_ticks)
	await shader_fuel_tween.finished
	

func refuel_pos() -> Vector3:
	return $RefuelSpot.global_position
