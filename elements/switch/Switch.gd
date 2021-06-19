extends Node2D

var state = false

export var can_swap = true

func swap():
	if GS.dragged_module != null:
		GS.dragged_module.end_drag()
	
	if not can_swap:
		return
		
	can_swap = false
		
	if state:
		$AnimationPlayer.play("Close")
		state = false
	else:
		$AnimationPlayer.play("Open")
		state = true
		
	$SwitchS.pitch_scale = rand_range(0.95, 1.05)
	$SwitchS.play()
		
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				swap()
