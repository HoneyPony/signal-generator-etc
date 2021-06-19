extends "res://ModuleBase.gd"

var tick = 0

var max_time_to_tick = 1.0

var time_to_tick = max_time_to_tick

onready var tick_leds = [
	$SwitchLED,
	$SwitchLED2,
	$SwitchLED3,
	$SwitchLED4,
	$SwitchLED5,
	$SwitchLED6,
	$SwitchLED7,
	$SwitchLED8,
]

onready var sign_leds = [
	$SwitchLED9,
	$SwitchLED10,
	$SwitchLED11,
	$SwitchLED12,
	$SwitchLED13,
	$SwitchLED14,
	$SwitchLED15,
	$SwitchLED16,
]

onready var switches = [
	$Switch,
	$Switch2,
	$Switch3,
	$Switch4,
	$Switch5,
	$Switch6,
	$Switch7,
	$Switch8,
]

onready var output_jacks = [
	$OutJack,
	$OutJack2,
	$OutJack3,
]

func _ready():
	for led in sign_leds:
		led.on_color = sign_leds[0].on_color
		led.off_color = sign_leds[0].off_color
	render()

func render():
	for i in range(0, 8):
		tick_leds[i].set_led(i == tick)
			
	for i in range(0, 8):
		sign_leds[i].set_led(i == tick and switches[i].state)
			
			
	for jack in output_jacks:
		if switches[tick].state:
			jack.output_state = 1.0
		else:
			jack.output_state = 0.0

func mod_process(delta):
	if not GS.run_rover:
		tick = 0
		time_to_tick = max_time_to_tick
		render()
		return
		
	time_to_tick -= delta
	
	if time_to_tick <= 0:
		tick = (tick + 1) % 8
		time_to_tick = max_time_to_tick
		
		render()
		
	
