extends Node

func _ready():
	GS.reset_state()
	get_tree().change_scene_to(MoonLoader.Game)
