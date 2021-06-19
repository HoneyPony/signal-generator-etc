extends CPUParticles2D

func _process(delta):
	var v = Vector2(0, -1)
	v = v.rotated(-global_rotation)
	
	direction = v
