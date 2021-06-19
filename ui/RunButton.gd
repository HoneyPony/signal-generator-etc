extends Button

onready var moon_viewport = get_node("../../ViewportContainer/Viewport")

func _on_RunButton_pressed():
	if GS.run_rover:
		moon_viewport.reload_moon()
	
	GS.run_rover = !GS.run_rover
	
func _process(delta):
	
	
	if GS.run_rover:
		text = "STOP"
	else:
		text = "RUN"
