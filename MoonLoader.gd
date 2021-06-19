extends Node

var moons = [
	preload("res://moon/Moon1.tscn")
]

func get_instance():
	return moons[GS.moon_index].instance()
