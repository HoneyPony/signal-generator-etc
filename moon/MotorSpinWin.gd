extends Node

var accum = 0
var last = 0

var has_moved = false

func _ready():
	last = get_parent().rotation_degrees

func _process(delta):
	var in_pos = get_parent().global_position.distance_squared_to(Vector2.ZERO) < 0.05
	if not in_pos:
		has_moved = true
	
	var ag = get_parent().rotation_degrees
	
	var d = ag - last
	if abs(d) > 180.0:
		d = (360.0 - abs(d)) * -sign(d)
	
	accum += d
	#print(accum, " ", d)
	last = ag
	
	if abs(accum) >= 720:
		if not has_moved:
			GS.won_level = true
			
	if has_moved:
		GS.mission_status_label.text = "Mission failed! Rover must turn in place"
	else:
		GS.mission_status_label.text = "Degrees turned: " + String(int(accum))
