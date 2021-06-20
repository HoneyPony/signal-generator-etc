extends Node

var time_correct = 0.0
var time_incorrect = 0.0

var max_time_correct = 15.0
var max_time_incorrect = 0.2

export var expecting_pulse = false

func bstate(s):
	return abs(s) > 0.02
	
func is_correct_pulse():
	var exp_left = pulse_left >= 0
	var exp_right = pulse_right >= 0
	
	GS.antenna_exp[0] = exp_left
	GS.antenna_exp[1] = exp_right
	
	return exp_left == bstate(GS.antenna_out[0]) and exp_right == bstate(GS.antenna_out[1])
	
var last_left = false
var last_right = false

var pulse_left = -1
var pulse_right = -1
	
func update_pulse(delta):
	pulse_left = clamp(pulse_left - delta, -1, 0.5)
	pulse_right = clamp(pulse_right - delta, -1, 0.5)
	
	if GS.rover_sensor_left and not last_left:
		pulse_left = 0.5
	if GS.rover_sensor_right and not last_right:
		pulse_right = 0.5
		
	last_left = GS.rover_sensor_left
	last_right = GS.rover_sensor_right

func is_correct():
	if expecting_pulse:
		return is_correct_pulse()
		
	GS.antenna_exp[0] = GS.rover_sensor_left
	GS.antenna_exp[1] = GS.rover_sensor_right
		
	return GS.rover_sensor_left == bstate(GS.antenna_out[0]) and GS.rover_sensor_right == bstate(GS.antenna_out[1])

func _physics_process(delta):
	# call to update state
	is_correct()
	
	if expecting_pulse:
		update_pulse(delta)
	
	if not GS.run_rover:
		time_correct = 0
		time_incorrect = 0
	else:
		if time_incorrect >= max_time_incorrect:
			if is_instance_valid(GS.mission_status_label):
				GS.mission_status_label.text = "Mission failed! Too much wrong data."
			return
		
		if is_correct():
			time_incorrect = 0
			time_correct += delta
		else:
			time_incorrect += delta
		
	var percent = int((time_correct / max_time_correct) * 100)
	if is_instance_valid(GS.mission_status_label):
		GS.mission_status_label.text = "Percent verified: " + String(percent) + "%"
		
	if GS.won_level:
		if is_instance_valid(GS.mission_status_label):
			GS.mission_status_label.text = "Completely verified!"
		
	if percent >= 100:
		GS.won_level = true
	
