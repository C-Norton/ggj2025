extends Area3D

var is_dragging = false
var offset = Vector3.ZERO  # Offset between mouse position and object position
var previous_mouse_pos = Vector2.ZERO  # Track previous mouse position

# Reduced sensitivity multiplier for movement
@export var sensitivity = 0.005  # Lower values make the object move slower relative to the mouse

# Detect if the click starts on the CollisionShape3D
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:  # If mouse button is pressed, start dragging
			is_dragging = true
			previous_mouse_pos = get_viewport().get_mouse_position()  # Track where the mouse was clicked
		else:  # If mouse button is released, stop dragging
			is_dragging = false
			offset = Vector3.ZERO

# While dragging, update the position of the Area3D
func _process(delta):
	if is_dragging:
		var mouse_pos = get_viewport().get_mouse_position()  # Get the current mouse position
		var mouse_delta = mouse_pos - previous_mouse_pos  # Calculate how much the mouse moved since the last frame

		# Debugging: print mouse movement and new position
		#print("Mouse Delta: ", mouse_delta)

		# Map the mouse movement to the z and y positions of the 3D node
		var new_position = global_transform.origin
		new_position.x = global_transform.origin.x  # Lock the X position, don't change
		new_position.y += mouse_delta.y * -sensitivity  # Invert Y movement (up/down)
		new_position.z += mouse_delta.x * sensitivity  # Adjust Z movement (forward/backward)

		# Update the object's position based on the translated mouse movement
		global_transform.origin = new_position

		# Update the previous mouse position to the current one
		previous_mouse_pos = mouse_pos
