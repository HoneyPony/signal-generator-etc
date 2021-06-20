extends Position2D

# 0 for left, 1 for right
export var turn = 0

var signal_length = -1

var has_started_signal = false

func start_signal():
	if has_started_signal:
		return
		
	has_started_signal = true
	signal_length = 0.3333333333333333333

func _physics_process(delta):
	var ant = 0.0
	$Mark.visible = false
	if signal_length >= 0:
		$Mark.visible = true
		ant = 1.0
	if signal_length >= -0.2:
		GS.antenna_in[turn] = ant
	signal_length -= delta
	signal_length = max(signal_length, -1)
	
	var dist_to_rover = global_position.distance_to(GS.rover.global_position)
	
	if dist_to_rover < 6:
		start_signal()
		
	
