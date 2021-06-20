extends Node

func reset_state():
	dragged_jack = null
	dragged_module = null
	dragged_misc = null

	left_motor_power = 0.0
	right_motor_power = 0.0

	camera_scale_fac = 1.0
	camera_scale_inv = 1.0
	camera_position = Vector2.ZERO
	camera = null

	ui_capture_mouse = false

	run_rover = false

	rover = null

	won_level = false

	#moon_index = 0

	# True if the camera should load with default properties,
	# false if the camera should copy old properties
	reset_moon_camera = true

	moon_camera_zoom_fac = 0.0
	moon_camera_zoom_level  = 0.0
	moon_camera_position = Vector2.ZERO

	may_spawn_patch_cable = true
	next_patch_cable = null

	mark_jack_for_trash = false
	
	mission_status_label = null
	
	enable_hover_count = 0
	
	moon_viewport = null
	
	tut_index = -1
	
	window_with_handle_left = null
	window_with_handle_right = null
	window_with_handle_bottom = null
	
	rover_sensor_front = false
	rover_sensor_front_rock = false
	rover_sensor_left = false
	rover_sensor_left_rock = false
	rover_sensor_right = false
	rover_sensor_right_rock = false
	
	antenna_out = [ 0.0 , 0.0 , 0.0 , 0.0 ]
	antenna_exp = [ false, false, false, false ]
	antenna_in = [ 0.0, 0.0, 0.0, 0.0 ]
	
	rover_m_left_p = 0.0
	rover_m_left_r = 0.0
	rover_m_right_p = 0.0
	rover_m_right_r = 0.0
	
var transition = null

func switch_scene(scn):
	if transition != null:
		transition.transition_to(scn)
	else:
		get_tree().change_scene_to(scn)

var dragged_jack = null
var dragged_module = null
var dragged_misc = null

var left_motor_power = 0.0
var right_motor_power = 0.0

var camera_scale_fac = 1.0
var camera_scale_inv = 1.0
var camera_position = Vector2.ZERO
var camera = null

var ui_capture_mouse = false

var run_rover = false

var rover = null

var won_level = false

var moon_index = 0

# True if the camera should load with default properties,
# false if the camera should copy old properties
var reset_moon_camera = true

var moon_camera_zoom_fac = 0.0
var moon_camera_zoom_level  = 0.0
var moon_camera_position = Vector2.ZERO

var may_spawn_patch_cable = true
var next_patch_cable = null

var mark_jack_for_trash = false

var mission_status_label = null

var rover_sensor_front = false
var rover_sensor_front_rock = false
var rover_sensor_left = false
var rover_sensor_left_rock = false
var rover_sensor_right = false
var rover_sensor_right_rock = false

var enable_hover_count = 0

var moon_viewport = null

var tut_index = -1

var window_with_handle_left = null
var window_with_handle_right = null
var window_with_handle_bottom = null

var antenna_out = [ 0.0 , 0.0 , 0.0 , 0.0 ]
var antenna_exp = [ false, false, false, false ]
var antenna_in = [ 0.0, 0.0, 0.0, 0.0 ]

var rover_m_left_p = 0.0
var rover_m_left_r = 0.0
var rover_m_right_p = 0.0
var rover_m_right_r = 0.0
