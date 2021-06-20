extends Button

const EXIT_INDEX = -10

export var index = 0

func _on_MissionButton_pressed():
	if index == EXIT_INDEX:
		GS.switch_scene(load("res://MainMenu.tscn"))
		#get_tree().change_scene("res://MainMenu.tscn")
		return
	
	GS.moon_index = index
	#GS.reset_state()
	#get_tree().change_scene_to(MoonLoader.Game)
	GS.switch_scene(MoonLoader.GameProxy)
