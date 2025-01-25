extends Node3D

@onready var animated_sprite : AnimatedSprite3D = $"../AnimatedSprite3D"

var is_dragging = false
var drag_origin : Vector2 = Vector2.ZERO
@export var drag_threshold: float = 25.0

var previous_mouse_pos = Vector2.ZERO  # Track previous mouse position

func _ready():
	GameManager.connect("mouse_released", _on_click_release)
	
	
func _on_click_release(_true):
	
	is_dragging = false
	animated_sprite.stop()
	animated_sprite.play("default")
	#print("HIT")
	#print("is_dragging: ", is_dragging)
	


# Called every frame
func _process(delta: float) -> void:
	if not is_dragging:  # When not dragging, always reset to default
		#animated_sprite.play("default")
		return
	else:
		var mouse_pos = get_viewport().get_mouse_position()
		var drag_vector = mouse_pos - drag_origin  # Vector from origin to current mouse position
		var distance = drag_vector.length()
		#print("DISTANCE ", distance)

		if distance >= drag_threshold:
			# Trigger the animation only if distance is large enough
			var angle = calculate_angle(drag_vector)
			var segment = calculate_segment(angle)
			play_animation_for_segment(segment)
		#else:
			## If distance is too small, revert to default animation
			#animated_sprite.play("default")

# Input event handling for click (start dragging)
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Start dragging
			is_dragging = true
			drag_origin = get_viewport().get_mouse_position()
		else:
			# Stop dragging and reset to default
			is_dragging = false
			#animated_sprite.play("default")  # Stop dragging and return to default animation

# Function to calculate angle
func calculate_angle(vector: Vector2) -> float:
	var angle = atan2(vector.y, vector.x)
	angle = -rad_to_deg(angle) + 90
	if angle < 0:
		angle += 360
	return angle

# Function to calculate segment from angle
func calculate_segment(angle: float) -> int:
	return int(floor(angle / 45.0)) % 8

# Function to play animation based on segment
func play_animation_for_segment(segment: int) -> void:
	match segment:
		0: 
			animated_sprite.play("stick_down")
		1: 
			animated_sprite.play("stick_down_right")
		2: 
			animated_sprite.play("stick_right")
		3: 
			animated_sprite.play("stick_up_right")
		4: 
			animated_sprite.play("stick_up")
		5: 
			animated_sprite.play("stick_up_left")
		6: 
			animated_sprite.play("stick_left")
		7: 
			animated_sprite.play("stick_down_left")
			
			
func play_animation_for_button(animation: String) -> void:
	print("playing anim")
	animated_sprite.play(animation)
