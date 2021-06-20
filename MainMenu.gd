extends Control



func _ready():
	$OptMenu.hide()

func _on_PlayButton_pressed():
	#GS.reset_state()
	get_tree().change_scene_to(MoonLoader.MissionSelect)
	



func _on_OptButton_pressed():
	$OptMenu.visible = !$OptMenu.visible
