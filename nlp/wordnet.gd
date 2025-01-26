extends Node

var LETTERS = [
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
]

var strip = RegEx.new()

var DICT_ROOT = "res://nlp/wordnet-dictionary/src/data/"
var STOP_WORDS_PATH = "res://nlp/stop-words.txt"

var DICT = {}
var STOP = {}

var STOP_DATA_VAL = {"stop": true}

func _ready() -> void:
	strip.compile(r"^\s+|\s+$")
	
	for l in LETTERS:
		DICT[l] = load_letter(l)
	
	load_stop_words()


func clean(w:String):
	var c = w.to_lower()
	strip.sub(c, "")
	return c

func search(w:String):
	w = clean(w)
	if w.length() < 1:
		return
	
	var bank = DICT[w[0]]
	if not bank:
		return
	
	if w in bank:
		return bank[w]
	 
	if w in STOP:
		return STOP[w]
	
	return
	

func load_letter(l:String):
	var path = DICT_ROOT + l + ".json"
	
	var f = FileAccess.open(path, FileAccess.READ)
	var data = JSON.new()
	var error = data.parse(f.get_as_text())
	if error == OK:
		return data.data
	return

func load_stop_words():
	var f = FileAccess.open(STOP_WORDS_PATH, FileAccess.READ)
	var data = f.get_as_text().split("\n")
	for w in data:
		STOP[w] = STOP_DATA_VAL 
