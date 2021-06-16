extends "res://ModuleBase.gd"

onready var inputs = [
	$JackIn,
	$JackIn2,
	$JackIn3,
	$JackIn4,
]

onready var leds = [
	$SwitchLED,
	$SwitchLED2,
	$SwitchLED3,
	$SwitchLED4,
]

func get_inputs():
	return inputs

func mod_process(delta):
	for i in range(0, 4):
		leds[i].set_led(abs(inputs[i].get_state()) > 0.02)
