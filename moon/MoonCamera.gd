extends Camera2D

var zoom_level = 0
var zoom_fac = 1

var min_zoom_level = -11

export var max_zoom_level = 11

var parent_viewport: Viewport
var ui_rect

# Called when the node enters the scene tree for the first time.
func _ready():
	# Apparently we need to re-set current to make the viewport work
	current = false
	
	parent_viewport = get_viewport().get_parent().get_viewport()
	ui_rect = get_viewport().get_parent().get_node("../../TextureRect")
	
	if GS.reset_moon_camera:
		GS.reset_moon_camera = false
	else:
		zoom_level = GS.moon_camera_zoom_level
		zoom_fac = GS.moon_camera_zoom_fac
		position = GS.moon_camera_position
		
		zoom = Vector2(zoom_fac, zoom_fac)
		
		#print("zl, zf, p: ", zoom_level, " ", zoom_fac, " ", position)

func zoom_calc():
	zoom_level = clamp(zoom_level, min_zoom_level, max_zoom_level)
	
#	var zoom_center = get_global_mouse_position()
	
#	var offset_base = zoom_center - position
	
	#var offset_1 = offset_base * zoom_fac
	
	zoom_fac = pow(1.09050773267, zoom_level)
	
	zoom = Vector2(zoom_fac, zoom_fac)
	
	#print("zl, zf, p: ", zoom_level, " ", zoom_fac, " ", position)
	
	#var offset_2 = offset_base * zoom_fac
	
	#position += offset_1 - offset_2

func _input(event):
#	if GS.ui_capture_mouse:
#		
	var mouse = parent_viewport.get_mouse_position()#get_local_mouse_position() * GS.camera_scale_fac + get_viewport().size * 0.5
	
#	if mouse.x <= rect.target_x:
#		return
#
	if mouse.x <= ui_rect.target_x:
		return
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_level -= 1
				zoom_calc()
			# zoom out
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_level += 1
				zoom_calc()
				
var dragging = false
var last_drag = Vector2.ZERO

func mouse_is_mine():
	var mouse = parent_viewport.get_mouse_position()
	
	if mouse.x <= ui_rect.target_x:
		return false
	
	return true
	
onready var max_rect = get_node("../CameraMax").get_rect()
				
func _process(delta):
	current = true
	
	GS.moon_camera_position = position
	GS.moon_camera_zoom_fac = zoom_fac
	GS.moon_camera_zoom_level = zoom_level
	
	if dragging:
		if Input.is_action_pressed("mouse_middle"):
			var mouse = get_local_mouse_position()
			var dif = mouse - last_drag
			
			position -= dif
			
			last_drag = mouse
		else:
			dragging = false
	
	if Input.is_action_just_pressed("mouse_middle"):
		if mouse_is_mine():
			dragging = true
			last_drag = get_local_mouse_position()
			
	var vs = get_viewport().size
	var min_x = max_rect.position.x + vs.x * 0.5 * zoom_fac
	var max_x = max_rect.end.x - vs.x * 0.5 * zoom_fac
	var center_x = (max_rect.position.x + max_rect.end.x) * 0.5
	min_x = min(center_x, min_x)
	max_x = max(center_x, max_x)
	
	var min_y = max_rect.position.y + vs.y * 0.5 * zoom_fac
	var max_y = max_rect.end.y - vs.y * 0.5 * zoom_fac
	var center_y= (max_rect.position.y + max_rect.end.y) * 0.5
	min_y = min(center_y, min_y)
	max_y = max(center_y, max_y)
	
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)
