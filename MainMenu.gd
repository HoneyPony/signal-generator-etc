extends Control

var MissionSelect = preload("res://ui/MissionSelect.tscn")

func _ready():
	$OptMenu.hide()

func _on_PlayButton_pressed():
	get_tree().change_scene_to(MissionSelect)
	



func _on_OptButton_pressed():
	$OptMenu.visible = !$OptMenu.visible
