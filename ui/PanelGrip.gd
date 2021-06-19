extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var on_right = true

var colorrect

var target_x = 32

func _ready():
	#if not on_right:
	colorrect = get_node("../ColorRect")
	

func _process(delta):
	if not Input.is_action_pressed("mouse_click"):
		dragging = false
	
	if not dragging:
		if on_right:
			var needed_margin = get_parent().margin_left
			needed_margin = -needed_margin
			
			target_x = get_viewport().size.x - needed_margin
	
	if dragging:
		if on_right:
			target_x = get_viewport().get_mouse_position().x
			
			var size = get_viewport().size
			var max_x = size.x - 32
			
			target_x = clamp(target_x, 0, max_x)
			
			var needed_margin = size.x - target_x
			
			needed_margin = -needed_margin
			
			#actual_margin += (needed_margin - actual_margin) * 0.2
					
			get_parent().margin_left = needed_margin
			
			# needed margin here is negative..
			colorrect.margin_right = max(400 + needed_margin, 0)
		else:
			target_x = get_viewport().get_mouse_position().x
			
			var size = get_viewport().size
			var min_x = 32
			var max_x = size.x
			
			target_x = clamp(target_x, min_x, max_x)
			
			var needed_margin = target_x
			
			#needed_margin = -needed_margin
			
			#actual_margin += (needed_margin - actual_margin) * 0.2
					
			get_parent().margin_right = needed_margin
			colorrect.margin_left = min(-400 + needed_margin - 32, 0)
		

var dragging = false

func start_drag():
	dragging = true

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_drag()
