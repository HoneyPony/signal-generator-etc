extends "res://ModuleBase.gd"

onready var inputs = [
	$JackIn,
	$JackIn2,
	$JackIn3,
	$JackIn4,
]

onready var leds = [
	$LED1,
	$LED2,
	$LED3,
	$LED4,
]

onready var leds2 = [
	$LED5,
	$LED6,
	$LED7,
	$LED8,
]

func get_inputs():
	return inputs

func mod_process(delta):
	for i in range(0, 4):
		var s = inputs[i].get_state()
		GS.antenna_out[i] = s
		
		leds[i].set_led(boolstate(s))
		
		leds2[i].set_led(GS.antenna_exp[i])
