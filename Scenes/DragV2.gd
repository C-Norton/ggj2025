extends Node3D

var is_dragging = false
var previous_mouse_pos = Vector2.ZERO  # Track previous mouse position

# Exported sensitivity multiplier for movement
@export var sensitivity = 0.005  # Lower values make the object move slower relative to the mouse

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass  # You can initialize other things here if needed.

# Detect mouse input events (e.g., clicks)
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start dragging on click
				is_dragging = true
				previous_mouse_pos = get_viewport().get_mouse_position()  # Track where the mouse was clicked
			else:
				# Stop dragging when the mouse button is released
				is_dragging = false

# Update the position of the object while dragging
func _process(delta: float) -> void:
	if is_dragging:
		var mouse_pos = get_viewport().get_mouse_position()  # Get the current mouse position
		var mouse_delta = mouse_pos - previous_mouse_pos  # Calculate how much the mouse moved since the last frame

		# Update the position of the object based on mouse movement, but only move it left/right (x-axis)
		var new_position = global_transform.origin
		new_position.z += mouse_delta.x * sensitivity
		new_position.y += -mouse_delta.y * sensitivity

		# Update the object's position based on the translated mouse movement
		global_transform.origin = new_position

		# Update the previous mouse position to the current one
		previous_mouse_pos = mouse_pos
