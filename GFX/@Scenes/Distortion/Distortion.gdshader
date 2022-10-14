shader_type canvas_item;

uniform vec2 distortion_center = vec2(0.5);
uniform float distortion_force: hint_range(0f, 1f);
uniform float distortion_size: hint_range(0f, 1f);
uniform float distortion_thickness: hint_range(0f, 1f);

vec2 get_distortion_disp(
	vec2 target_uv, vec2 center, float force, float size, float thickness,
	vec2 screen_pixel_size
){
	float ratio = screen_pixel_size.x / screen_pixel_size.y;
	vec2 scaledUV = (target_uv - vec2(0.5,0.0)) / vec2(ratio, 1) + vec2(0.5,0.0);
	float mask = (1.0 - smoothstep(size-0.1,size, length(scaledUV - center))) * 
	smoothstep(size-thickness-0.1,size-thickness, length(scaledUV - center));
	vec2 disp = normalize(scaledUV - center) * force * mask;
//	return texture(target,target_uv - disp);
	return disp;
}

void fragment(){
	vec2 distortion_disp = get_distortion_disp(
		SCREEN_UV, distortion_center, distortion_force, distortion_size, distortion_thickness, SCREEN_PIXEL_SIZE
	);
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - distortion_disp);
}
