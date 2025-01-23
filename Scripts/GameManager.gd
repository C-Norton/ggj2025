extends Node3D

var mouse = Vector2()
@onready var main_cam: Camera3D = $MainCam
@onready var top_drag: Area3D = $BubbleOSLayer/TopDrag

func _input(event):
	if event is InputEventMouse:
		mouse = event.position
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_selection()

func get_selection():
	var worldspace = main_cam.get_world_3d().direct_space_state
	var start = main_cam.project_ray_origin(mouse)
	var end = start + main_cam.project_ray_normal(mouse) * 1000  # Correct ray end calculation
	
	print("Ray Start: ", start, " Ray End: ", end)  # Debugging
	
	var ray_params = PhysicsRayQueryParameters3D.new()
	ray_params.from = start
	ray_params.to = end
	ray_params.collision_mask = 1  # Adjust to match your object's collision layer
	
	var result = worldspace.intersect_ray(ray_params)
	if result:
		print("Object hit: ", result.collider, " at ", result.position)
	else:
		print("No object hit!")
	print("TARGET: ", top_drag.global_position)
	
	# Optional: Visualize the ray
	visualize_ray(start, end)

func visualize_ray(start: Vector3, end: Vector3):
	var ray_mesh = ImmediateMesh.new()
	var ray_visual = MeshInstance3D.new()
	add_child(ray_visual)
	ray_visual.mesh = ray_mesh
	
	ray_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	ray_mesh.surface_add_vertex(start)
	ray_mesh.surface_add_vertex(end)
	ray_mesh.surface_end()
