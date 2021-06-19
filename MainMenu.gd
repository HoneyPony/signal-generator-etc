extends Control

var Game = preload("res://Game.tscn")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(Game)
	

