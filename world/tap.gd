extends Node3D
class_name Tap

@export var neighbour: Tap
@export var fuel_color: Color
@export var create_color: Color
var held_ball: Ball = null
var fuel_amount: float = .5 # 0 to 1

enum State {
	Empty,
	Growing,
	Holding,
}
@export var state: State = State.Empty


@onready var game := Util.find_game_parent(self)

func _process(_delta: float) -> void:
	$Tap.set_instance_shader_parameter("fuel_amount", fuel_amount)
	$Tap.set_instance_shader_parameter("fuel_color", fuel_color)
	$Tap.set_instance_shader_parameter("create_color", create_color)

var delay_ticks := 0
var current_line: Variant = null
var target_size := 0.0

func tick(poem: Poem):
	if state == State.Holding:
		delay_ticks -= 1
		if delay_ticks <= 0:
			command_release_ball()
		return
	if state == State.Empty:
		current_line = poem.next()
		var parameters = current_line.parameterize()
		delay_ticks = int(parameters["delay"] * game.max_delay_ticks)
		var size_scale := game.size_curve.sample(parameters["size"])
		target_size = size_scale * game.max_target_size
		command_set_color(Color.from_string(parameters["color"], Color.WHITE))
		command_create_ball()
		held_ball.grow_ball(target_size)
	else:
		command_stop_growing()
	
	

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
	if state != State.Empty:
		push_error("Tap is not empty!")
		return
	create_ball()
	state = State.Growing

func command_set_color(color: Color):
	create_color = color

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
	
