extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var colorrect

var target_y = 32

func _ready():
	GS.window_with_handle_bottom = self
	pass
	#if not on_right:
	#colorrect = get_node("../ColorRect")
	
var target_override = -1

func calc_target():
	var size = get_viewport().size
	var max_y = size.y - 32
	
	target_y = clamp(target_y, 0, max_y)
	
	var needed_margin = size.y - target_y
	
	needed_margin = -needed_margin
	
	#actual_margin += (needed_margin - actual_margin) * 0.2
			
	get_parent().margin_top = needed_margin
	
func _process(delta):
	
	
	if not Input.is_action_pressed("mouse_click"):
		dragging = false
	
	if not dragging:
		var needed_margin = get_parent().margin_top
		needed_margin = -needed_margin
		
		target_y = get_viewport().size.y - needed_margin
	
	if dragging:
		target_y = get_viewport().get_mouse_position().y
		
		calc_target()
		
	if target_override != -1:
		target_y = target_override
		calc_target()
		target_override = -1
		dragging = false
		return
			
			# needed margin here is negative..
			#colorrect.margin_right = max(400 + needed_margin, 0)
		
var dragging = false

func start_drag():
	dragging = true

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_drag()
