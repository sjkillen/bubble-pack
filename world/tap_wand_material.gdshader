shader_type spatial;

instance uniform float fuel_amount;
instance uniform vec3 fuel_color : source_color;
instance uniform vec3 create_color : source_color;

void fragment() {
	ALBEDO = create_color;
}

