extends Node3D


@onready var animation_player : AnimationPlayer = $AnimationPlayer  # The AnimationPlayer to control animations

var is_dragging = false
var drag_origin : Vector2 = Vector2.ZERO

var previous_mouse_pos = Vector2.ZERO  # Track previous mouse position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dragging:
		var mouse_pos = get_viewport().get_mouse_position()
		var angle = (mouse_pos - drag_origin).angle()
		angle = wrapf(angle, 0, TAU)
		
		var segment = int(angle / (TAU / 8))
		# Trigger the appropriate animation based on the segment
		trigger_animation(segment)


func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start dragging on click
				is_dragging = true
			else:
				# Stop dragging when the mouse button is released
				is_dragging = false

# Trigger animation based on the segment
func trigger_animation(segment: int) -> void:
	match segment:
		0:
			animation_player.play("Animation0")
		1:
			animation_player.play("Animation1")
		2:
			animation_player.play("Animation2")
		3:
			animation_player.play("Animation3")
		4:
			animation_player.play("Animation4")
		5:
			animation_player.play("Animation5")
		6:
			animation_player.play("Animation6")
		7:
			animation_player.play("Animation7")
