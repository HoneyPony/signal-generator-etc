extends ColorRect

func _process(delta):
	visible = GS.won_level


func _on_NextMission_pressed():
	GS.moon_index += 1
	GS.reset_state()
	get_tree().change_scene_to(MoonLoader.Game)


func _on_Continue_pressed():
	GS.moon_viewport.reload_moon()
	GS.won_level = false


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
