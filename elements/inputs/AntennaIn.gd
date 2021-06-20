extends "res://ModuleBase.gd"

onready var outputs = [
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

func mod_process(delta):
	for i in range(0, 4):
		var s = GS.antenna_in[i]
		
		leds[i].set_led(boolstate(s))
		outputs[i].output_state = s
