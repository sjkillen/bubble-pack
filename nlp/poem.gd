extends Node2D
class_name Poem

var ix = 0

var lines = []

@export var text_1: Array[String]
@export var text_2: Array[String]
@export var text_3: Array[String]
@export var text_4: Array[String]

var last_line: Node  = null

var initial_data: Array[Array] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lines = get_children()
	
	for t in [text_1, text_2, text_3, text_4]:
		if t.size() > 2:
			initial_data.append(t)
	
	if initial_data.size():
		load_data(initial_data)



func next():
	if ix >= lines.size():
		ix = 0
	
	if last_line:
		last_line.end_turn()
	
	var ret = lines[ix]
	ret.start_turn()
	last_line = ret
	
	ix += 1
	
	return ret

func load_data(data: Array[Array]):
	for i in range(lines.size()):
		lines[i].load_data(data[i])
