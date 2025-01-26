shader_type spatial;

instance uniform float fuel_amount;
instance uniform vec3 fuel_color : source_color;
instance uniform vec3 create_color : source_color;
uniform vec3 no_fuel_color : source_color;

void fragment() {
	if ((1.0-UV.y) >= fuel_amount) {
		ALBEDO = no_fuel_color;
	} else {
		ALBEDO = fuel_color;
	}
}
