extends Button



func _on_ExitButton_pressed():
	GS.reset_state()
	get_tree().change_scene_to(MoonLoader.MissionSelect)
	
	
