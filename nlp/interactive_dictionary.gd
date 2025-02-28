extends Node2D

var word: String

@export var SyllableCounter: Node




func _on_go_pressed() -> void:
	word = $WordInput.text
	
	var data = $Wordnet.search(word)
	
	if not data:
		return
	
	$PartOfSpeech.text = data["definitions"][0]["partOfSpeech"]
	$Definition.text = data["definitions"][0]["meaning"]
	$Syllables.text = str($SyllableCounter.count(word))
	$ColorDisplay.color = $Colorizer.colorize(word)
