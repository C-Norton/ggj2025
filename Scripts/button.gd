extends Node3D

@onready var animated_sprite : AnimatedSprite3D = $"../AnimatedSprite3D"

var is_clicking = false
@export var animation : String

var previous_mouse_pos = Vector2.ZERO  # Track previous mouse position

func _ready():
	GameManager.connect("mouse_released", _on_click_release)
	
	
func _on_click_release(_true):
	
	is_clicking = false
	animated_sprite.stop()
	animated_sprite.play("default")
	print("HIT")
	#print("is_dragging: ", is_dragging)
	


# Called every frame
func _process(delta: float) -> void:
	if not is_clicking:  # When not dragging, always reset to default
		return
	else:
		play_animation_for_button(animation)


# Input event handling for click (start dragging)
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Start dragging
			is_clicking = true
			
		else:
			# Stop dragging and reset to default
			is_clicking = false
			#animated_sprite.play("default")  # Stop dragging and return to default animation


# Function to play animation based on segment
func play_animation_for_button(animation: String) -> void:
	print("playing anim")
	animated_sprite.play(animation)
