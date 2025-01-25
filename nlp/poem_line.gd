extends Node2D

@export var CADENCE = 500


@export var is_valid = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Delay.connect("text_changed", validate)
	$Size.connect("text_changed", validate)
	$Colour.connect("text_changed", validate)

func validate() -> bool:
	if not $Delay.is_valid or not $Size.is_valid or not $Colour.is_valid:
		is_valid = false
		return false
	is_valid = true
	return true

func parameterize():
	if not validate():
		return
	return {
		"color": $Colorizer.colorize($Colour.text),
		"size": $Size.text.length() * 20,
		"delay": $SyllableCounter.count($Delay.text) * CADENCE
	}
