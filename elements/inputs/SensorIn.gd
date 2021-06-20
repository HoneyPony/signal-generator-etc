extends "res://ModuleBase.gd"

onready var outputs = [
	$JackOut,
	$JackOut2,
	$JackOut3,
	$JackOut4,
	$JackOut5,
	$JackOut6
]

func get_rock_state(i):
	if not $RockS.state:
		return false
		
	if i == 0:
		return GS.rover_sensor_left_rock
	if i == 1:
		return GS.rover_sensor_front_rock
	return GS.rover_sensor_right_rock
	
func get_rover_state(i):
	if not $RoverS.state:
		return false
		
	if i == 0:
		return GS.rover_sensor_left
	if i == 1:
		return GS.rover_sensor_front
	return GS.rover_sensor_right

func get_state_b():
	var which = $ChooserDial.stage
	
	var state = false
	state = state or get_rock_state(which)
	state = state or get_rover_state(which)
	
	return state

func mod_process(delta):	
	var state_num = 0.0
	var state_b = get_state_b()
	if state_b:
		state_num = 1.0
		
	$SwitchLED.set_led(state_b)
		
	for output in outputs:
		output.output_state = state_num
			
		
