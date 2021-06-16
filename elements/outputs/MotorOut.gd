extends "res://ModuleBase.gd"

onready var inputs = [
	$JackIn,
	$JackIn2,
	$JackIn3,
	$JackIn4,
	$JackIn5,
]

func get_inputs():
	return inputs

func reverse_to_sign(input):
	var b = boolstate(input)
	if b:
		return -1
	return 1
	
func calc(in1, in2):
	return in1.get_state() * reverse_to_sign(in2.get_state())

#const speed = ((20.0 / PI) * PI / 2.0) / 0.5
const speed = 32

func dial_to_mul():
	var s = $SpeedDial.stage
	return s
	
func speed_mul():
	var d = dial_to_mul()
	var j = $JackIn5.get_state()
	return d * j

func mod_process(delta):
	var cur_speed = speed_mul() * speed
	
	GS.left_motor_power = calc($JackIn, $JackIn2) * cur_speed
	GS.right_motor_power = calc($JackIn3, $JackIn4) * cur_speed
