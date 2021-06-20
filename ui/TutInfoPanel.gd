extends ColorRect

export var index = 0

export var needed_left = -1
export var needed_right = -1

export var needed_bottom = -1

func setup_margins():
	if needed_left != null:
		GS.window_with_handle_left.target_override = needed_left
	if needed_right != null:
		GS.window_with_handle_right.target_override = get_viewport().size.x - needed_right
	
	if needed_bottom != null:
		GS.window_with_handle_bottom.target_override = get_viewport().size.y - needed_bottom

var viz_delay = false

func _process(delta):
	visible = viz_delay
	
	var was_v = viz_delay
	viz_delay = GS.tut_index == index
	
	if was_v != viz_delay and viz_delay:
		setup_margins()
