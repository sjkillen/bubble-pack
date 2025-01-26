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

var after_decay_tween: Tween = null
func harden():
	if after_decay_tween != null:
		after_decay_tween.kill()
	after_decay_tween = create_tween()
	after_decay_tween.tween_property(self, "color", Color(0.0, 0.0, 0.0), game.time_between_ticks)
	await after_decay_tween.finished
	after_decay_tween = null
	
func refuel_float_to(pos: Vector3):
	$CollisionShape3D.queue_free()
	if after_decay_tween != null:
		after_decay_tween.kill()
	after_decay_tween = create_tween()
	after_decay_tween.set_parallel()
	after_decay_tween.tween_property(self, "global_position", pos, game.time_between_ticks)
	after_decay_tween.tween_property(self, "radius", 0.01, game.time_between_ticks)
	await after_decay_tween.finished
	after_decay_tween = null
	queue_free()

func _process(_delta: float) -> void:
	if oob_timer and freeze:
		oob_timer.wait_time = game.ball_oob_time
	$MeshInstance3D.mesh.radius = radius
	$MeshInstance3D.mesh.height = radius * 2.0
	var collision_shape: CollisionShape3D = get_node_or_null("CollisionShape3D")
	if collision_shape != null:
		collision_shape.shape.radius = radius
	$MeshInstance3D.set_instance_shader_parameter("color", color)
	var decay_factor = 1.0
	if decay_timer != null:
		decay_factor = decay_timer.time_left / (game.ball_radius_decay_ratio * radius)
	$MeshInstance3D.set_instance_shader_parameter("decay_factor", decay_factor)
	freeze = not ball_released

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
	flick()
	ball_released = true
	decay_timer = Timer.new()
	add_child(decay_timer)
	decay_timer.one_shot = true
	decay_timer.start(game.ball_radius_decay_ratio * radius)
	await decay_timer.timeout
	game.ball_decayed(self)
	
func flick() -> void:
	var p := -position
	p.y = 0.0
	apply_central_impulse(p.normalized() * game.flick_power)

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
