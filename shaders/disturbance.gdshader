shader_type canvas_item;

uniform sampler2D smoke;
uniform float speed = 0.3;
uniform float size = 0.08;
uniform sampler2D screen_texture : hint_screen_texture;

void fragment(){
	
	vec2 smoke_uv = UV + TIME * speed;
	vec4 smoke_color = texture(smoke, fract(smoke_uv));
	smoke_color = clamp(smoke_color * size, 0.0, 1.0);
	vec4 img_color = texture(screen_texture, SCREEN_UV + vec2(smoke_color.g - size/2.0,0.0));
	
	COLOR = vec4(img_color);
}