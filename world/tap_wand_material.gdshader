shader_type spatial;

instance uniform float fuel_amount;
instance uniform vec3 fuel_color : source_color;
instance uniform vec3 create_color : source_color;

void fragment() {
	ALBEDO = create_color;
	EMISSION = ALBEDO;
	ANISOTROPY = 1.0;
	METALLIC = 0.95;
	SPECULAR = 1.0;
	ROUGHNESS = 0.95;
}
