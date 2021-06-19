extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var rect = get_node("../PartsBinLayer/Control/TextureRect")
onready var rect2 = get_node("../RoverViewLayer/Control/TextureRect")

var zoom_level = 0
var zoom_fac = 1

var min_zoom_level = -22

# Called when the node enters the scene tree for the first time.
func _ready():
	GS.camera = self
	#get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(0, 0), 0.5)
	pass # Replace with function body.

func zoom_calc():
	zoom_level = max(zoom_level, min_zoom_level)
	
	var zoom_center = get_global_mouse_position()
	
	var offset_base = zoom_center - position
	
	var offset_1 = offset_base * zoom_fac
	
	zoom_fac = pow(1.09050773267, zoom_level)
	
	zoom = Vector2(zoom_fac, zoom_fac)
	
	var offset_2 = offset_base * zoom_fac
	
	position += offset_1 - offset_2
	
	GS.camera_scale_fac = 1.0 / zoom_fac
	GS.camera_scale_inv = zoom_fac

func _input(event):
#	if GS.ui_capture_mouse:
#		return

	var mouse = get_local_mouse_position() * GS.camera_scale_fac + get_viewport().size * 0.5
	
	if mouse.x <= rect.target_x:
		return
		
	if mouse.x >= rect2.target_x:
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
				# call the zoom function

var dragging = false
var last_drag = Vector2.ZERO

func mouse_is_mine():
	var mouse = get_local_mouse_position() * GS.camera_scale_fac + get_viewport().size * 0.5
	
	if mouse.x <= rect.target_x:
		return false
		
	if mouse.x >= rect2.target_x:
		return false
	
	return true
	
var PatchCable = preload("res://elements/PatchCable.tscn")
	
func spawn_patch_cable():
	GS.may_spawn_patch_cable = false
	
	var cable = PatchCable.instance()
	GS.next_patch_cable = cable
	
	get_parent().add_child(cable)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		
	GS.camera_position = global_position
	
	if GS.may_spawn_patch_cable:
		spawn_patch_cable()
