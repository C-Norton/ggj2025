extends Node2D

@onready var polygon = $Polygon2D
@onready var screen_material = $ScreenLayer.material
@onready var screen_layer: Sprite2D = $ScreenLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(screen_layer.texture.get_size())
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Convert Polygon2D's global position to UV coordinates for the shader
	var global_position = polygon.global_position
	var screen_rect = $ScreenLayer.get_rect()
	var uv_position = (global_position - screen_rect.position) / screen_rect.size

	# Update the shader's uniform with the position and radius
	screen_material.set_shader_parameter("window_position", uv_position)
	screen_material.set_shader_parameter("window_radius", 0.2) # Adjust radius as needed
