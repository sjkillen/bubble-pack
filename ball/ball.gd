extends RigidBody3D
class_name Ball

@export var radius: float
var target_radius: float
@export var color: Color

var oob_timer: Timer = null
var decay_timer: Timer = null
var growth_tween: Tween = null
@onready var game := Util.find_game_parent(self)

var ball_released := false

func _process(_delta: float) -> void:
	$MeshInstance3D.mesh.radius = radius
	$MeshInstance3D.mesh.height = radius * 2.0
	$CollisionShape3D.shape.radius = radius
	$MeshInstance3D.set_instance_shader_parameter("color", color)
	var decay_factor = 1.0
	if decay_timer != null:
		decay_factor = decay_timer.time_left / (game.ball_radius_decay_ratio * radius)
	$MeshInstance3D.set_instance_shader_parameter("decay_factor", decay_factor)
	gravity_scale = float(ball_released)

func grow_ball(amount: float):
	if growth_tween != null:
		radius = target_radius
		growth_tween.kill()
	growth_tween = create_tween()
	target_radius = amount
	growth_tween.tween_property(self, "radius", target_radius, game.time_between_ticks)
	await growth_tween.finished
	growth_tween = null
	

func release_ball():
	ball_released = true
	decay_timer = Timer.new()
	add_child(decay_timer)
	decay_timer.start(game.ball_radius_decay_ratio * radius)
	await decay_timer.timeout
	game.ball_decayed(self)
	

func make_oob_timer() -> Timer:
	if not ball_released:
		return
	if oob_timer != null:
		return null
	var timer := Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.start(game.ball_oob_time)
	return timer

func kill_oob_timer():
	if oob_timer == null:
		return
	oob_timer.queue_free()
