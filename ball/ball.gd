extends RigidBody3D
class_name Ball

@export var radius: float
@export var color: Color

var oob_timer: Timer = null

func _ready() -> void:
	$MeshInstance3D.mesh.radius = radius
	$MeshInstance3D.mesh.height = radius * 2.0
	$CollisionShape3D.shape.radius = radius
	$MeshInstance3D.set_instance_shader_parameter("color", color)

func make_oob_timer() -> Timer:
	if oob_timer != null:
		return null
	var timer := Timer.new()
	timer.one_shot = true
	add_child(timer)
	timer.start(GameGlobal.ball_oob_time)
	return timer

func kill_oob_timer():
	if oob_timer == null:
		return
	oob_timer.queue_free()
