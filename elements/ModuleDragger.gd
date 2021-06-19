extends Area2D

var dragging = false
var on_mouse = false

var last_drag = Vector2.ZERO
var drag_start = Vector2.ZERO
var drag_accum = Vector2.ZERO

var valid_position = Vector2.ZERO
var has_valid_position = false

var real_parent = null
var layer_parent = null

var is_in_place = false
var has_been_placed = false

onready var module = get_parent()

func initialize(real_parent_, layer_parent_, pos):
	#valid_position = global_position
	real_parent = real_parent_
	layer_parent = layer_parent_
	
	module.call_deferred("remove_child", self)
	real_parent.call_deferred("add_child", self)
	
	call_deferred("finish_init", pos)
	
func finish_init(pos):
	global_position = pos
	module.global_position = pos
	start_drag()
	

func _on_mouse_entered():
	on_mouse = true

func _on_mouse_exited():
	on_mouse = false
	
func start_drag():
	# Don't start drag if a jack is being dragged
	if GS.dragged_jack != null:
		return
		
	if GS.dragged_module != null:
		return
		
	if GS.dragged_misc != null:
		return
	
	dragging = true
	GS.dragged_module = self
	last_drag = get_global_mouse_position()
	
	real_parent.remove_child(module)
	
	layer_parent.add_child(module)
	#drag_start = get_parent().global_position
	drag_start = global_position
	drag_accum = Vector2.ZERO
	
	set_collision_layer_bit(3, true)
	set_collision_mask_bit(3, true)
	
func end_drag():
	dragging = false
	
	if GS.dragged_module == self:
		GS.dragged_module = null
		
		module.get_parent().remove_child(module)
		real_parent.add_child(module)
		
		module.scale = Vector2.ONE
		
		if not is_in_place:
			module.queue_free()
			self.queue_free()
			
			#print("Module deleted")
		
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(3, false)
	
	has_been_placed = true
	
	

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_drag()
				
				
func is_intersecting_modules():
	var areas = get_overlapping_areas()
	for a in areas:
		if a.get_collision_layer_bit(2):
			return true
	return false
	
func is_intersecting_left_ui():
	var areas = get_overlapping_areas()
	for a in areas:
		if a.get_collision_layer_bit(3):
			return true
	return false
	
func can_use_cur_position_as_valid():
	var position_rounded = (global_position / 70.0).ceil() * 70.0
	return (position_rounded - global_position).length_squared() < 0.000001
				
func _physics_process(delta):
	var on_ui = is_intersecting_left_ui()
	
	if on_ui:
		is_in_place = false
		
	
	
	if is_intersecting_modules():
		if dragging and not on_ui:
			module.modulate = Color(0.8, 0, 0, 1)
		if has_valid_position:
			global_position = valid_position
			module.global_position = valid_position
		else:
			is_in_place = false
	else:
		module.modulate = Color(1, 1, 1, 1)
		if not on_ui and can_use_cur_position_as_valid():
			var last_v = valid_position
			valid_position = global_position
			has_valid_position = true
			is_in_place = true
			
			if (last_v - valid_position).length_squared() > 1:
				$Move.pitch_scale = rand_range(0.95, 1.05)
				$Move.play()
		
		#get_parent().global_position = valid_position

	if not Input.is_action_pressed("mouse_click"):
		end_drag()
	
	if dragging:
		var mouse = get_global_mouse_position()
		drag_accum += mouse - last_drag
		
		last_drag = mouse
		
		var drag_target = drag_start + drag_accum
		if not on_ui:
			drag_target = (drag_target / 70.0).ceil() * 70.0
		
		global_position = drag_target
		module.global_position = global_position
		#get_parent().position = drag_target
		#module.scale = Vector2(GS.camera_scale_fac, GS.camera_scale_fac)
		
