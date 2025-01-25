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

func _ready() -> void:
	game.tick.connect(tick)
	
func _process(_delta: float) -> void:
	$Tap.set_instance_shader_parameter("fuel_amount", fuel_amount)
	$Tap.set_instance_shader_parameter("fuel_color", fuel_color)
	$Tap.set_instance_shader_parameter("create_color", create_color)

func tick():
	# Todo execute poetry
	if state == State.Growing:
		held_ball.grow_ball(game.growth_rate)

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
	
