shader_type canvas_item;

uniform vec3 tint;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR.rgb = vec3(COLOR.r + COLOR.g + COLOR.b) / 3.0;
	COLOR.rgb = (COLOR.rgb + tint.rgb) / 2.0;
}


