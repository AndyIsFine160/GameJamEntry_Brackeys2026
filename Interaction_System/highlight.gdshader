shader_type spatial;
uniform float strength;

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = vec3(1, 1, 1);
	ALPHA = strength;
}

