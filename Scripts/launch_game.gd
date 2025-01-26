extends Node3D

@onready var sprite_3d: Sprite3D = $Sprite3D
@export var app: PackedScene
var is_clicking = false



func _ready():
	GameManager.connect("mouse_released", _on_click_release)
	
	
func _on_click_release(_true):
	
	is_clicking = false
	


# Called every frame
#func _process(delta: float) -> void:
	#if not is_clicking:  # When not dragging, always reset to default
		#return
	#else:
		#play_animation_for_button(animation)


# Input event handling for click (start dragging)
func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Start dragging
			is_clicking = true
		if event.is_released():
			# Start dragging
			is_clicking = false
			var instance = app.instantiate()
			add_child(instance)

			# Set its position
			instance.global_transform.origin = position
			

			
			# Set the rotation explicitly to -90° on the Y-axis and 0° on the X and Z axes
			var transform = instance.transform  # Local transform
			transform.basis = Basis(Vector3(0, 1, 0), deg_to_rad(0))  # Rotate -90° on Y
			transform.origin.z = 0.6
			instance.transform = transform
