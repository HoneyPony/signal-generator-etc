extends ColorRect

func _ready():
	var mis = get_node("Control/FinalMis")
	mis.visible = GS.moon_index >= MoonLoader.last_index()
	if(GS.moon_index >= MoonLoader.last_index()):
		get_node("Control/NextMission").hide()

func _process(delta):
	var was = visible
	visible = GS.won_level

	if visible and not was:
		$Win.play()

func _on_NextMission_pressed():
	GS.moon_index += 1
	#GS.reset_state()
	GS.switch_scene(MoonLoader.GameProxy)


func _on_Continue_pressed():
	GS.moon_viewport.reload_moon()
	GS.won_level = false


func _on_BackToMenu_pressed():
	#GS.reset_state()
	GS.switch_scene(MoonLoader.MissionSelect)
