extends Control

onready var MissionSelect = preload("res://ui/MissionSelect.tscn")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(MissionSelect)
	

