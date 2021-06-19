extends Button

export var index = 0

func _on_MissionButton_pressed():
	GS.moon_index = index
	get_tree().change_scene_to(MoonLoader.Game)
