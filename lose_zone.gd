extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Ball:
		var timer: Timer = body.make_oob_timer()
		if timer == null:
			return
		timer.timeout.connect(ball_alarm.bind(body))

func _on_body_exited(body: Node3D) -> void:
	if body is Ball:
		body.kill_oob_timer()


func ball_alarm(_ball: Ball):
	print("You would have lost")
