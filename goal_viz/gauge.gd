extends ColorRect
class_name Gauge

@export var panic_threshold = 0.1

@onready var mat: ShaderMaterial = $MarginContainer/TextureRect.material
@onready var label: Label = $MarginContainer/TextureRect/Label

var target_ideal := 0.0
var target_amount := 0.0

var shader_ideal = 0.0
var shader_amount = 0.0

func _process(delta: float) -> void:
	shader_ideal = lerp(shader_ideal, target_ideal, delta)
	shader_amount = lerp(shader_amount, target_amount, delta)
	if is_nan(shader_amount):
		shader_amount = target_amount
	if is_nan(shader_ideal):
		shader_ideal = target_ideal
	mat.set_shader_parameter("ideal_amount", shader_ideal)
	mat.set_shader_parameter("amount", shader_amount)

func set_ideal(v: float):
	target_ideal = v	
	
func set_amount(amount: float):
	target_amount = amount
	var diff = abs(amount - target_ideal)
	label.visible = diff > panic_threshold
		
