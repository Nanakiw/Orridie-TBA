shader_type canvas_item;

uniform sampler2D color_gradient;
uniform sampler2D noise_texture;
uniform float speed: hint_range (0.0,5.0)=0.0;
uniform float variation: hint_range (0.0,300.0)=0.3;
uniform float width: hint_range (0.0,10.0)=1.5;

void fragment(){
	
	vec2 noise_uv = vec2(UV.x+TIME*speed, UV.y-TIME*speed);
	float noise_sample = texture(noise_texture, noise_uv).r;
	float x_offset = noise_sample*variation - variation/2.0;
	COLOR = texture(color_gradient, vec2((UV.x-0.5)/width + 0.5 + x_offset/width, UV.y));
}