extends Sprite

var trash_tex = preload("res://ui/cable_box_trash.svg")
var normal_tex = preload("res://ui/cable_box.svg")

func handle_trash():
	var areas = $JackDetect.get_overlapping_areas()
	
	if GS.dragged_jack.get_node("Area2D") in areas:
		modulate = Color(0.8, 0.8, 0.8, 1.0)
		return true
		
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = !GS.run_rover
	
	var s = 0.5 * GS.camera_scale_inv
	scale = Vector2(s, s)
	
	position.y = get_viewport().size.y * -0.5 * GS.camera_scale_inv

	var user_dragging_new_cable = false
	
	if GS.next_patch_cable != null:
		if GS.next_patch_cable.cur_mode == GS.next_patch_cable.Mode.Spawning:
			user_dragging_new_cable = true
		
	var mark_for_trash = false
		
	texture = normal_tex	
	modulate = Color.white
	if user_dragging_new_cable:
		z_index = 300
	else:
		z_index = 50
		
		if GS.dragged_jack != null:
			texture = trash_tex
			
			mark_for_trash = handle_trash()
	
	GS.mark_jack_for_trash = mark_for_trash
	
