extends Node3D

signal mouse_released(is_released : bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("Click"):
		#print("Signal Emitted")
		emit_signal("mouse_released", true)
	if Input.is_action_just_pressed("Click"):
		#print("Signal Emitted")
		#Play sound
		pass
