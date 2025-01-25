extends TextEdit

class_name PoetryWord

@export var wordnet: Node

@export var is_valid = false

var data = null



func _on_text_changed() -> void:
	validate()

func validate():
	data = wordnet.search(text)
	if data:
		$GoodMarker.visible = true
		is_valid = true
		return
	$GoodMarker.visible = false
	is_valid = false
