extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var viewport_offset = get_viewport().size / 2
	offset = viewport_offset - GS.camera_position * GS.camera_scale_fac
	#offset = GS.camera_position * GS.camera_scale_fac
	scale = Vector2(GS.camera_scale_fac, GS.camera_scale_fac)
