extends Button

const EXIT_INDEX = -10

export var index = 0

func _on_MissionButton_pressed():
	if index == EXIT_INDEX:
		get_tree().change_scene("res://MainMenu.tscn")
		return
	
	GS.moon_index = index
	#GS.reset_state()
	#get_tree().change_scene_to(MoonLoader.Game)
	get_tree().change_scene_to(MoonLoader.GameProxy)
