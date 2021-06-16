extends Area2D

var dragging = false
var on_mouse = false

var last_drag = Vector2.ZERO
var drag_start = Vector2.ZERO
var drag_accum = Vector2.ZERO

var valid_position

func _ready():
	valid_position = get_parent().position

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
	
	drag_start = get_parent().position
	drag_accum = Vector2.ZERO
	
func end_drag():
	dragging = false
	
	if GS.dragged_module == self:
		GS.dragged_module = null

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				start_drag()
				
				
func _physics_process(delta):
	var areas = get_overlapping_areas()
	if areas.empty():
		var last_v = valid_position
		valid_position = get_parent().position
		
		if (last_v - valid_position).length_squared() > 1:
			$Move.pitch_scale = rand_range(0.95, 1.05)
			$Move.play()
	else:
		get_parent().position = valid_position

	if not Input.is_action_pressed("mouse_click"):
		end_drag()
	
	if dragging:
		var mouse = get_global_mouse_position()
		drag_accum += mouse - last_drag
		
		last_drag = mouse
		
		var drag_target = drag_start + drag_accum
		drag_target = (drag_target / 70.0).round() * 70.0
		
		get_parent().position = drag_target
		
