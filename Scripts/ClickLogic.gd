extends Camera3D

var mouse = Vector2()
@onready var target: Area3D = $"../BubbleOSLayer/TopDrag"

func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_selection()

func get_selection():
	var worldspace = get_world_3d().direct_space_state
	var start = project_ray_origin(mouse)
	var direction = -global_transform.basis.z  # Forward direction of the camera
	var end = start + direction * 1000  # Extend ray length

	# Debug ray details
	print("Ray Start: ", start)
	print("Ray End: ", end)

	# Create raycast parameters
	var ray_params = PhysicsRayQueryParameters3D.new()
	ray_params.from = start
	ray_params.to = end
	ray_params.collision_mask = 1  # Match the `Area3D`'s collision mask

	# Perform raycast
	var result = worldspace.intersect_ray(ray_params)
	if not result:
		print("No object hit!")
	else:
		print("Hit object: ", result.collider)
		print("Collision point: ", result.position)

		# Check if the collider is your `Area3D`
		if result.collider is Area3D:
			print("Hit Area3D: ", result.collider.name)
