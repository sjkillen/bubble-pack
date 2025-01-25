extends AbstractSpawner

@export var escape_velocity: float = 3.0

func spawn(ball: Ball):
	ball.global_position = $SpawnMarker.global_position
	ball.linear_velocity = Vector3(0.0, -escape_velocity, 0.0)
