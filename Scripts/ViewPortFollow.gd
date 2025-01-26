extends SubViewportContainer



@onready var sub_viewport_container : SubViewportContainer = $"."
@onready var display_image: Sprite3D = $"../Display Image"
@onready var viewport: SubViewport = $ScreenDisplayViewport





func _ready():
	var scene_to_display = preload("res://Wobbix/Scenes/LevelWob.tscn").instantiate()
	viewport.add_child(scene_to_display)
	print("SCENE ADDED")
