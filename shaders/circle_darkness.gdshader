shader_type canvas_item;


uniform vec4 color = vec4(1.0);
uniform float radius : hint_range(0.57, 2.0, 0.01);
uniform float fade_speed : hint_range(0.005, 0.05, 0.001);


float circle(vec2 position, float radius_circle, float feather)
{
	return smoothstep(radius_circle, radius_circle + feather, length(position - vec2(0.5)));
}


void fragment(){
	
	float outer = circle(vec2(UV.x, UV.y), radius, 0.01);
	
	float fade_effect = cos(TIME*2.35) * fade_speed;
	
	float inner = 1.0 - circle(vec2(UV.x, UV.y), radius-0.5, 0.1 - fade_effect);
	
	COLOR = color;
	COLOR.a -= outer + inner;
	
}