extends ColorRect

export var is_del = false

func _process(delta):
	if is_del:
		var v = false
		if GS.dragged_module != null:
			if GS.dragged_module.has_been_placed:
				if GS.run_rover:
					if GS.dragged_module.is_intersecting_left_ui():
						v = true
		visible = v
	else:
		var v = false
		var mod = Color(1, 1, 1, 1)
		
		if GS.dragged_module != null:
			if GS.dragged_module.has_been_placed:
				if not GS.run_rover:
					v = true
					if GS.dragged_module.is_intersecting_left_ui():
						mod = Color(0.8, 0.8, 0.8, 1)
				
		visible = v
		modulate = mod
