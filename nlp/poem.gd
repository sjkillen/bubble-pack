extends Node2D

var ix = 0

var lines = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lines = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func next():
	if ix >= lines.size():
		ix = 0
	
	var ret = lines[ix]
	
	ix += 1
	
	return ret
