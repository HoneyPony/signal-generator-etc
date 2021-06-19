extends Area2D

onready var rect = get_node("../../PartsBinLayer/Control/TextureRect")

func _process(delta):
	var v = get_viewport().size
	var x = (-v.x * 0.5 + rect.target_x) * GS.camera_scale_inv
	
	position.x = x
	
	var size = 1000 * GS.camera_scale_inv
	$CollisionShape2D.shape.extents = Vector2(size, size)
	$CollisionShape2D.position.x = -size
