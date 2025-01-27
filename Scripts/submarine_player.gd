extends Camera3D

@onready var rigid_body_3d: RigidBody3D = $littlewhalesubmarinething/RigidBody3D
@onready var game_nodes = get_tree().get_nodes_in_group("Game")
@export var rotation_speed: float = 5.0  # Speed at which the submarine rotates
var target_angle = 0.0  # Store the target angle
@onready var littlewhalesubmarinething: Node3D = $littlewhalesubmarinething

var move_speed: float = 0.0  # The current speed of the submarine
var movement_duration: float = 3.0  # How long to move the ship (in seconds)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Lock the linear axes if necessary
	rigid_body_3d.axis_lock_linear_x = true
	rigid_body_3d.axis_lock_linear_y = true
	
	# Ensure that we are connecting the signal to the correct node
	if game_nodes.size() > 0:
		# each node represents a different button based on heirarchy
		game_nodes[0].connect("rotate_ship", _on_rotate_ship)
		game_nodes[1].connect("move_ship", _on_move_ship)
	else:
		print("No nodes found in group 'Game'")

# Called when the signal is emitted to move the ship
func _on_move_ship(speed: float) -> void:
	move_speed = speed / 50
	await get_tree().create_timer(movement_duration).timeout  # Wait for the timer to finish
	move_speed = 0  # Stop movement after the specified duration

func _on_rotate_ship(new_target_angle: float) -> void:
	target_angle = new_target_angle + 90 

func _process(delta: float) -> void:
	if target_angle != null:
		var current_rotation = littlewhalesubmarinething.rotation_degrees.x  # Assuming it's on the x-axis

		var angle_diff = wrapf(target_angle - current_rotation, -180, 180)

		var new_rotation_x = current_rotation + angle_diff * rotation_speed * delta

		littlewhalesubmarinething.rotation_degrees.x = new_rotation_x

	if move_speed != 0:
		move_submarine(delta)

# Function to move the submarine
func move_submarine(delta: float) -> void:
	var adjusted_rotation = littlewhalesubmarinething.rotation_degrees.x
	
	var rotation_in_radians = deg_to_rad(adjusted_rotation)
	
	var direction = Vector3(cos(rotation_in_radians), sin(rotation_in_radians), 0)  # Movement in the x-y plane
	
	direction = direction.normalized()

	# Apply movement based on the direction and speed
	$".".position += direction * move_speed * delta
