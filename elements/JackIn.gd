extends Node2D

export var default_state = 0.0

var jack_coupling = null

export var is_input = true
var output_state = 0

func get_state():
	if not is_input:
		return output_state

	var j = jack_coupling
	if j == null:
		return default_state
	
	j = j.paired_jack
	if j == null:
		return default_state
		
	j = j.plug_coupling
	if j == null:
		return default_state
		
	# we have got the other jackin!
	return clamp(j.output_state, 0, 64)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func max_x():
	return $MaxDist.global_position.x
	
func max_unaligned_x():
	return $MaxUnaligned.global_position.x
	
func push_x_1():
	return $PushbackDist.global_position.x
	
func push_x_2():
	return $PushbackDist2.global_position.x

func region_cutoff_x():
	return $Cutoff.global_position.x

func max_y():
	return $MaxDist.global_position.y
	
func max_unaligned_y():
	return $MaxUnaligned.global_position.y
	
func push_y_1():
	return $PushbackDist.global_position.y
	
func push_y_2():
	return $PushbackDist2.global_position.y

func region_cutoff_y():
	return $Cutoff.global_position.y

func plug_is_x():
	var rot = polar2cartesian(1, rotation)
	if abs(rot.y) < 0.5:
		return true
	return false

func _on_area_entered(area):
	# don't start plugging in if somethings alredy plugged in
	if jack_coupling != null:
		return
	
	var jack = area.get_parent()
	
	if plug_is_x():
		if sign(polar2cartesian(1, jack.rotation).x) != sign(polar2cartesian(1, rotation).x):
			return 
	else:
		if sign(polar2cartesian(1, jack.rotation).y) != sign(polar2cartesian(1, rotation).y):
			return 
		
	if jack.plug_coupling == self:
		return
	
	if jack.dragging:
		if jack.plug_target == null:
			jack.plug_target = self

func _on_area_exited(area):
	var jack = area.get_parent()
	
	if jack.plug_coupling == self:
		return
	
	if jack.plug_target == self:
		jack.plug_target = null
