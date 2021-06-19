extends ColorRect

func _process(delta):
	var v = false
	var mod = Color(1, 1, 1, 1)
	
	if GS.dragged_module != null:
		if GS.dragged_module.has_been_placed:
			v = true
			if GS.dragged_module.is_intersecting_left_ui():
				mod = Color(0.8, 0.8, 0.8, 1)
			
	visible = v
	modulate = mod
