shader_type spatial;

instance uniform vec3 color : source_color;

void fragment() {
	ALBEDO = color;
	EMISSION = color;
	ANISOTROPY = 1.0;
	METALLIC = 0.95;
	SPECULAR = 1.0;
	ROUGHNESS = 0.95;
}
