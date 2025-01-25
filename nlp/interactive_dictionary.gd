extends Node2D

var word: String


func _on_go_pressed() -> void:
	word = $WordInput.text
	
	var data = $Wordnet.search(word)
	
	if not data:
		return
	
	$PartOfSpeech.text = data["definitions"][0]["partOfSpeech"]
	$Definition.text = data["definitions"][0]["meaning"]
