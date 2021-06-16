extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var zoom_level = 0
var zoom_fac = 1

var min_zoom_level = -22

# Called when the node enters the scene tree for the first time.
func _ready():
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

func _input(event):
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
		dragging = true
		last_drag = get_local_mouse_position()
