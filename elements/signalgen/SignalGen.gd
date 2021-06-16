extends "res://ModuleBase.gd"

onready var inputs = [
	$JackIn,
	$JackIn2,
]

onready var out1 = [
	$Out1_1,
	$Out1_2,
	$Out1_3,
	$Out1_4,
]

onready var out2 = [
	$Out2_1,
	$Out2_2,
	$Out2_3,
	$Out2_4,
]

onready var outs = [
	$OutS_1,
	$OutS_2,
	$OutS_3,
	$OutS_4,
]

func get_inputs():
	return inputs
	
func dial_to_sig(dial):
	var s = dial.stage
	return s
	
func mod_process(delta):
	var d1 = dial_to_sig($Sig1) * $JackIn.get_state()
	var d2 = dial_to_sig($Sig2) * $JackIn2.get_state()
	var ds = d1 + d2
	
	for out in out1:
		out.output_state = d1
	for out in out2:
		out.output_state = d2
	for out in outs:
		out.output_state = ds
