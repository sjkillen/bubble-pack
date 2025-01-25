shader_type canvas_item;

uniform vec3 empty_color : source_color;
uniform vec3 fill_color : source_color;
uniform float amount = 0.5;
uniform float ideal_amount = 0.5;

void fragment() {
	if (UV.y <= amount) {
		COLOR.rgb = empty_color;
	} else {
		COLOR.rgb = fill_color;
	}
}
