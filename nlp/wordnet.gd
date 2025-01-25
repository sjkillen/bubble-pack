extends Node


var strip = RegEx.new()

var DICT_ROOT = "res://nlp/wordnet-dictionary/src/data/"

func _ready() -> void:
	strip.compile(r"^\s+|\s+$")


func clean(w:String):
	var c = w.to_lower()
	strip.sub(c, "")
	return c

func search(w:String):
	w = clean(w)
	if w.length() < 1:
		return
	
	var bank = load_letter(w[0])
	if not bank:
		return
	
	if w in bank:
		return bank[w]
	
	return
	

func load_letter(l:String):
	var path = DICT_ROOT + l + ".json"
	
	var f = FileAccess.open(path, FileAccess.READ)
	var data = JSON.new()
	var error = data.parse(f.get_as_text())
	if error == OK:
		return data.data
	return
