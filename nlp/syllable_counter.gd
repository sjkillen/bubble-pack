extends Node

var DIPHTHONG = r"i[aou]|uo|eo"

var VOWEL = ["a", "e", "i", "o", "u"]
var SILENT = r"e$"


var silent = RegEx.new()
var diphthong = RegEx.new()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diphthong.compile(DIPHTHONG)
	silent.compile(SILENT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func count(w:String):
	var data = silent.sub(w, "")
	data = diphthong.sub(data, "aha")
	var v = false
	var s = 0
	for l in data:
		if l in VOWEL:
			if not v:
				v = true
				s += 1
		else:
			v = false
	return s
				
	
