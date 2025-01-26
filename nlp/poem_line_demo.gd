extends Node2D

@export var CADENCE = 2000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball_center = $Ball.position



var old_vis = true

var default_data = {"color": "#ffffff", "size": 50, "delay": 1}
var data = default_data

var ball_center = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	react()
	
	if not $PoemLine.is_valid:
		data = default_data
		return
	data = $PoemLine.parameterize()

func react():
	$Ball.modulate = data["color"]
	var t = Time.get_ticks_msec()
	var vis = true
	var delay = int(data["delay"] * CADENCE)
	
	if delay > 0:
		vis = t % delay > (delay / 2)
	
	var nsize = Vector2(data["size"], data["size"])
	$Ball.size = nsize
	$Ball.position = ball_center - nsize / 7
	
	if vis != old_vis:
		$Ball.visible = vis
		old_vis = vis
		
func load_data(data: Array):
	$PoemLine.load_data(data)
	
	
func parameterize():
	return $PoemLine.parameterize()
