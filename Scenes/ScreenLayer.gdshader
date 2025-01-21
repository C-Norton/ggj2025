shader_type canvas_item;

uniform float window_center : hint_range(0.0, 1.0);
uniform vec2 window_position; // The center of the "cut-out" in normalized UV space
uniform float window_radius : hint_range(0.0, 1.0); // The radius of the cut-out

void fragment() {
    // Calculate the distance from the current pixel to the center of the window
    float distance_to_center = length(UV - window_center);

    // If the current pixel is inside the window radius, show the texture
    if (distance_to_center < window_radius) {
        // Apply the texture color (the content inside the window)
        COLOR = texture(TEXTURE, UV);
    } else {
        // Outside the window, discard the fragment (make it transparent)
        discard;
    }
}
