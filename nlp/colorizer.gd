extends Node

var VOWELS = ["a", "e", "i", "o", "u"]

@export var SyllableCounter: Node

func red(w:String):
	var q = w.length() % 3
	if q == 0:
		return "55"
	if q == 1:
		return "bb"
	return "ff"
	
func blue(w:String):
	var v = 0
	var c = 0

	for l in w:
		if l in VOWELS:
			v += 1
			continue
		c += 1
	
	var q = 1
	if c > 0:
		q = v / c
	
	if q > 0.7:
		return "ff"
	if q >= 0.5:
		return "bb"
	return "55"

func green(w: String):
	var q =  SyllableCounter.count(w)
	
	if q <= 2:
		return "55"
	if q <= 3:
		return "bb"
	return "ff"

func colorize(w:String):
	return "#" + red(w) + green(w) + blue(w)
