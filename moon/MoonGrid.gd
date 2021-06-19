extends Sprite

const SIZE = 2048

func _ready():
	# This allows us to move the camera separately from the tex -- good for
	# prototyping levels on top of the texture
	var cam = get_node("../Camera2D")
	get_parent().call_deferred("remove_child", self)
	cam.call_deferred("add_child", self)

func _process(delta):
	var target_size: Vector2 = get_viewport().size * get_parent().zoom_fac
	
	target_size = ((target_size / SIZE).ceil() + Vector2(2, 2)) * SIZE
	
	region_rect.size = target_size * 8
	
	position = target_size * -0.5
	
	global_position = (global_position / SIZE).floor() * SIZE
