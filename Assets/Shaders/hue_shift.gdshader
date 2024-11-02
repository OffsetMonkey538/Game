shader_type canvas_item;

uniform float hue_shift: hint_range(0.0, 1.0) = 0;

// Approximate hue to rgb
vec3 hueToRgb(float hue) {
	hue = hue;
	vec3 rgb;
	
	rgb.r = abs(hue * 6.0 - 3.0) - 1.0;
	rgb.g = 2.0 - abs(hue * 6.0 - 2.0);
	rgb.b = 2.0 - abs(hue * 6.0 - 4.0);
	
	return clamp(rgb, 0.0, 1.0);
}

void fragment() {
	COLOR.rgb = mix(COLOR.rgb, hueToRgb(hue_shift), 0.5);
}
