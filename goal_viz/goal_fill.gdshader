shader_type canvas_item;

uniform vec3 empty_color : source_color;
uniform vec3 fill_color : source_color;
uniform float amount = 0.5;
uniform float ideal_amount = 0.10;
uniform vec3 ideal_line_color : source_color;

void fragment() {
	if (abs(UV.y - (1.0-ideal_amount)) <= 0.01) {
		COLOR.rgb = ideal_line_color;
	}
	else if (UV.y <= amount) {
		COLOR.rgb = empty_color;
	} else {
		COLOR.rgb = fill_color;
	}
}
