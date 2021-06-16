extends "res://ModuleBase.gd"

onready var inputs = [
	$JackIn,
	$JackIn2,
	$JackIn3,
	$JackIn4,
]

func get_inputs():
	return inputs

func mod_process(delta):
	var result = 0.0
	
	for input in inputs:
		var is_true = abs(input.get_state()) > 0.02
		if is_true:
			result = 1.0
			break
			
	$JackOut.output_state = result
		
