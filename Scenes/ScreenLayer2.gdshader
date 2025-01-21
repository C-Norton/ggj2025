shader_type canvas_item;

// Uniforms for mask position and size
uniform vec2 window_position; // Center of the "cut-out" (in UV coordinates)
uniform float window_radius;  // Radius of the circular cut-out

void fragment() {
    vec2 uv = UV; // Get the UV coordinates of the fragment
    float dist = distance(uv, window_position);

    // Create the cut-out
    if (dist < window_radius) {
        discard; // Reveal the layer below
    }
}
