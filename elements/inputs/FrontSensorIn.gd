extends "res://ModuleBase.gd"

onready var outputs = [
	$JackOut,
	$JackOut2,
	$JackOut3,
	$JackOut4
]


func mod_process(delta):		
	for output in outputs:
		output.output_state = GS.rover_sensor_front
			
		
