shader_type spatial;
render_mode cull_back;

instance uniform float fuel_amount;
instance uniform vec3 fuel_color : source_color;
instance uniform vec3 create_color : source_color;
uniform vec3 no_fuel_color : source_color;

void fragment() {
	if ((1.0-UV.y) >= fuel_amount) {
		ALBEDO = no_fuel_color;
		ALPHA = 0.5;
	} else {
		ALBEDO = fuel_color;
		ALPHA = 1.0;
	}
	EMISSION = ALBEDO;
	ANISOTROPY = 1.0;
	METALLIC = 0.95;
	SPECULAR = 1.0;
	ROUGHNESS = 0.95;
}
