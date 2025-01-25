extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



var old_vis = true

var default_data = {"color": "#ffffff", "size": 50, "delay": 1}
var data = default_data

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	react()
	
	if not $PoemLine.is_valid:
		data = default_data
		return
	data = $PoemLine.parameterize()

func react():
	$Ball.modulate = data["color"]
	var t = Time.get_ticks_msec()
	var vis = true
	if data["delay"] > 0:
		vis = t % data["delay"] > (data["delay"] / 2)
	
	$Ball.size = Vector2(data["size"], data["size"])
	if vis != old_vis:
		$Ball.visible = vis
		old_vis = vis
	
	
