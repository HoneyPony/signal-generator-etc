extends "res://ModuleBase.gd"

onready var inputs = [
	$JackIn,
]

onready var outputs = [
	$JackOut,
	$JackOut2,
	$JackOut3,
	$JackOut4
]

func get_inputs():
	return inputs
	
func get_input_index(index):
	var is_true = abs(inputs[index].get_state()) > 0.02
	
	return is_true

func mod_process(delta):
	var result = 1.0
				
	if get_input_index(0):
		result = 0.0
			
	for output in outputs:
		output.output_state = result
