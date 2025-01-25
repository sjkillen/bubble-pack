shader_type spatial;

instance uniform float fuel_amount;
instance uniform vec3 fuel_color : source_color;

void fragment() {
	ALBEDO = fuel_color;
}

