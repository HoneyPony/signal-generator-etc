extends Node2D

export var off_color: Color
export var on_color: Color

export var anim: float = 0.0

func _process(delta):
	$switch_led.modulate = off_color.linear_interpolate(on_color, anim)

func on():
	if anim < 0.5:
		$AnimationPlayer.play("TurnOn")
	
func off():
	if anim > 0.5:
		$AnimationPlayer.play("TurnOff")

func set_led(is_on):
	if is_on:
		on()
	else:
		off()
