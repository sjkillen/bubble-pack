extends Node2D


@onready var PoemA = $A/Poem
@onready var PoemB = $B/Poem
@onready var PoemC = $C/Poem

"""
Interface:
	
	Access Poems via top level vars above.
	
	var line = $PoetryInterface.PoemA.next()
	var next_bubble_params = line.parameterize()
"""



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
