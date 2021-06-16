extends Sprite

func _process(delta):
	var target_size: Vector2 = get_viewport().size * get_parent().zoom_fac
	
	target_size = ((target_size / 70).ceil() + Vector2(2, 2)) * 70
	
	region_rect.size = target_size * 8
	
	position = target_size * -0.5
	global_position = (global_position / 70).floor() * 70
