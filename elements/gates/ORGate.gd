extends "res://ModuleBase.gd"

const TYPE_OR = 0
const TYPE_AND = 1

export var type = 0

onready var inputs = [
	$JackIn,
	$JackIn2,
	$JackIn3,
	$JackIn4,
]

onready var outputs = [
	$JackOut,
	$JackOut2,
	$JackOut3,
	$JackOut4
]

onready var switches = [
	$Switch,
	$Switch2,
	$Switch3,
	$Switch4,
]

func get_inputs():
	return inputs
	
func get_input_index(index):
	var is_true = abs(inputs[index].get_state()) > 0.02
	
	var switch = switches[index]
	if switch.state:
		is_true = !is_true
	
	return is_true
	
func _ready():
	if type == 0:
		for i in inputs:
			i.default_state = 0.0
	else:
		for i in inputs:
			i.default_state = 1.0

func mod_process(delta):
	var result = 0.0
	
	if type == 0:
		for i in range(0, 4):
			var is_true = get_input_index(i)
			if is_true:
				result = 1.0
				break
				
	if type == 1:
		result = 1.0
		for i in range(0, 4):
			var is_true = get_input_index(i)
			if not is_true:
				result = 0.0
				break
			
	for output in outputs:
		output.output_state = result
			
	#$JackOut.output_state = result
		
