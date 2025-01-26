extends Node2D


@export var is_valid = false

@export var SYL_PAR = 5.0
@export var LEN_PAR = 11.0

@onready var words = [$Delay, $Size, $Colour]

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
	
	var syl = $SyllableCounter.count($Delay.text)
	if syl == 0:
		syl = 1
	
	var delay = float(syl) / SYL_PAR
	
	if delay > 1:
		delay = 1.0
	if delay < 0.1:
		delay = 0.1
		
	var s = float($Size.text.length()) / LEN_PAR
	if s > 1.0:
		s = 1.0
	if s < 0.1:
		s = 0.1
	
	return {
		"color": $Colorizer.colorize($Colour.text),
		"size": s,
		"delay": delay #$SyllableCounter.count($Delay.text) * CADENCE
	}

func load_data(data: Array):
	for i in range(words.size()):
		words[i].text = data[i]
		words[i].validate()
	validate()
