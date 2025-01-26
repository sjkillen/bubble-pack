extends Node2D

@onready var sequence: Array[AudioStreamPlayer2D] = [
	$SongBasic,
	$SongAlgo2,
	$SongPoetry,
]

var active: AudioStreamPlayer2D

var ix = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func next():
	if ix >= sequence.size():
		return
	active = sequence[ix]
	active.play()
	active.connect("finished", next)
	ix += 1
