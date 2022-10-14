shader_type canvas_item;

uniform vec2 circle_center = vec2(0.5);
uniform float circle_size: hint_range(0f, 1f);
uniform float circle_scatter_intensity: hint_range(0f, 1f);
uniform vec4 circle_cover_color: hint_color;

float get_circle_cover_alpha(
	vec2 center, float size, float scatter_intensity,
	vec2 screen_pixel_size, vec2 screen_uv
){
	vec2 resolution = 1f / screen_pixel_size;

	vec2 current_pixel = screen_uv * resolution;
	vec2 circle_target_pixel = vec2(center.x, center.y) * resolution;
	float dist = distance(current_pixel, circle_target_pixel);

	float radius = size * length(resolution) ;

//	circle.a =  clamp((dist - radius), 0f, 1f);
	return  clamp ((dist-radius+1f) * 1f/(scatter_intensity * 1000f), 0f, 1f);
}

void fragment(){
	COLOR = circle_cover_color;
	COLOR.a *= get_circle_cover_alpha(
		circle_center, circle_size, circle_scatter_intensity, SCREEN_PIXEL_SIZE, SCREEN_UV);
}
