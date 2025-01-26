extends Camera3D

@onready var rigid_body_3d: RigidBody3D = $littlewhalesubmarinething/RigidBody3D
@onready var game_nodes = get_tree().get_nodes_in_group("Game")
@export var rotation_speed: float = 5.0  # Speed at which the submarine rotates
var target_angle = 0.0  # Store the target angle
@onready var littlewhalesubmarinething: Node3D = $littlewhalesubmarinething

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Lock the linear axes if necessary
	rigid_body_3d.axis_lock_linear_x = true
	rigid_body_3d.axis_lock_linear_y = true
	
	# Ensure that we are connecting the signal to the correct node
	if game_nodes.size() > 0:
		var game_node = game_nodes[0]  # Assuming you want the first node in the group
		game_node.connect("rotate_ship", _on_rotate_ship)
		game_node.connect("move_ship", _on_move_ship)
	else:
		print("No nodes found in group 'Game'")

# Called when the signal is emitted
func _on_move_ship(speed: float) -> void:
	# Get the current rotation (direction the submarine is facing)
	var rotation_in_radians = deg_to_rad(littlewhalesubmarinething.rotation_degrees.x)
	
	# Calculate the movement direction based on the rotation
	var direction = Vector3(sin(rotation_in_radians), 0, cos(rotation_in_radians))  # Forward movement in the x-z plane
	
	# Normalize the direction vector to ensure consistent movement speed
	direction = direction.normalized()

	# Apply the impulse in the calculated direction
	rigid_body_3d.apply_impulse(direction * speed)  # Impulse will move the submarine

func _on_rotate_ship(new_target_angle: float) -> void:
	# Apply an offset of +90 degrees to the target angle to fix direction inversion
	target_angle = new_target_angle + 90  # Add 90 degrees to the signal's value

# Rotate smoothly in the _process function
func _process(delta: float) -> void:
	# Only rotate if target angle is set
	if target_angle != null:
		# Get the current rotation of the submarine (not the camera)
		var current_rotation = littlewhalesubmarinething.rotation_degrees.x  # Assuming it's on the x-axis

		# Calculate the shortest angle difference
		var angle_diff = wrapf(target_angle - current_rotation, -180, 180)

		# Smoothly rotate towards the target angle
		var new_rotation_x = current_rotation + angle_diff * rotation_speed * delta

		# Apply the new rotation to the submarine (littlewhalesubmarinething)
		littlewhalesubmarinething.rotation_degrees.x = new_rotation_x
