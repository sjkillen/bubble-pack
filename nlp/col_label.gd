extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".connect("mouse_entered", show_tip)
	$".".connect("mouse_exited", hide_tip)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_tip():
	$Tooltip.visible = true
	
func hide_tip():
	$Tooltip.visible = false
