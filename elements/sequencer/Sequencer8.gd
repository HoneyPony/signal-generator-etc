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

onready var overrides = [
	$Over1,
	$Over2,
	$Over3,
	$Over4,
	$Over5,
	$Over6,
	$Over7,
	$Over8,
]

onready var inputs = [
	$Over1,
	$Over2,
	$Over3,
	$Over4,
	$Over5,
	$Over6,
	$Over7,
	$Over8,
	$JackIn
]

onready var output_jacks = [
	$OutJack,
	$OutJack2,
	$OutJack3,
	$OutJack4,
]

func get_time_setting():
	var stage = $TimeDial.stage
	
	var arr = [0.0625, 0.125, 0.25, 0.5, 1, 2, 4]
	if stage <= 0:
		return 0.0625
	if stage >= arr.size():
		return 4
	return arr[int(stage)]

func get_inputs():
	return inputs

func _ready():
	for led in sign_leds:
		led.on_color = sign_leds[0].on_color
		led.off_color = sign_leds[0].off_color
	render()

func get_state(index):
	if index >= 8:
		return false
	
	if overrides[index].jack_coupling != null:
		return boolstate(overrides[index].get_state())
	
	return switches[index].state

func render():
	for i in range(0, 8):
		tick_leds[i].set_led(i == tick)
			
	for i in range(0, 8):
		sign_leds[i].set_led(i == tick and get_state(i))
			
			
	for jack in output_jacks:
		if get_state(tick):
			jack.output_state = 1.0
		else:
			jack.output_state = 0.0

var has_seen_false = true

func mod_process(delta):
	
	var jack_in_state = $JackIn.get_state()
	
	if not boolstate(jack_in_state):
		has_seen_false = true
	#print("mod process -> ", self)
	
	max_time_to_tick = get_time_setting()
	
	if not GS.run_rover:
		tick = 8
		time_to_tick = 0.0 #max_time_to_tick
		render()
		return
		
	time_to_tick -= delta
	
	if time_to_tick <= 0:
		if tick < 8:
			tick = tick + 1
		
		var enable_tick = true
		
		if tick >= 8:
			
			if $JackIn.jack_coupling != null:
				enable_tick = boolstate(jack_in_state)
			
			if $SwitchT.state == true:
				if not has_seen_false:
					enable_tick = false
			
			if enable_tick:
				tick = 0
				has_seen_false = false
			
		if enable_tick:
			time_to_tick = max_time_to_tick
			
		render()
		
	
