shader_type spatial;

instance uniform vec3 create_color : source_color;

void fragment() {
	ALBEDO = create_color;
}

