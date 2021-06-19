extends Node

var Game = preload("res://Game.tscn")

var moons = [
	preload("res://moon/Moon1.tscn")
]

var titles = [
	"Straight to the Point"
]

func get_instance():
	return moons[GS.moon_index].instance()
