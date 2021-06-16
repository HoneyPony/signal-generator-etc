extends Node2D

var dragging = false

export var max_angle = 0.0
export var min_angle = 0.0

export var rounding = 0.01

export var init_rot = 0.0

var last_valid_rotation = 0

var stage

func start_drag():
	if GS.dragged_jack != null:
		return
	if GS.dragged_misc != null:
		return
	if GS.dragged_module != null:
		GS.dragged_module.end_drag()
	
		
	GS.dragged_misc = self
	
	dragging = true
	
func end_drag():
	dragging = false
	if GS.dragged_misc == self:
		GS.dragged_misc = null
		
func update_dial(enable_sound = true):
	if $dial.rotation_degrees < min_angle or $dial.rotation_degrees > max_angle:
		$dial.rotation_degrees = last_valid_rotation
	#$dial.rotation_degrees = clamp($dial.rotation_degrees, min_angle, max_angle)
	$dial.rotation_degrees = round($dial.rotation_degrees / rounding) * rounding
	
	var prev_stage = stage
	stage = ($dial.rotation_degrees - min_angle) / rounding
	if stage != prev_stage:
		if enable_sound:
			$Rot.pitch_scale = rand_range(0.95, 1.05)
			$Rot.play()
	
	last_valid_rotation = $dial.rotation_degrees
	
func _ready():
	$dial.rotation_degrees = init_rot
	update_dial(false)
	
func _process(delta):
	if not Input.is_action_pressed("mouse_click"):
		end_drag()
		
	if dragging:
		var direction = get_global_mouse_position() - $dial.global_position
		$dial.rotation = cartesian2polar(direction.x, direction.y).y
	
		update_dial()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_drag()
