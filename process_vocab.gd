extends Node2D

var DICT = "res://nlp/custom_dict.json"

var vocab = [
	"res://nlp/cs-terms.txt",
	"res://nlp/engineering-vocab.txt",
	"res://nlp/top-1000-common-words.txt"
	
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_data()


func process_row(r):
	var data = $Wordnet.search(r)
	return data

func process_data():
	var data = {}
	for d in vocab:
		var f = FileAccess.open(d, FileAccess.READ)
		var content = f.get_as_text()
		var rows = content.split("\n")
		for row in rows:
			if not row:
				continue
			var out = process_row(row)
			if out != null:
				data[row] = out
	
	var json = JSON.stringify(data)
	var ofile = FileAccess.open(DICT, FileAccess.WRITE)
	ofile.store_string(json)

	
