extends Node

var Game = preload("res://Game.tscn")

var moons = [
	null,
	preload("res://moon/Moon1.tscn"),
	preload("res://moon/Moon2.tscn"),
	preload("res://moon/Moon3.tscn"),
	preload("res://moon/Moon4.tscn"),
]

var titles = [
	"Welcome Aboard",
	"Straight to the Point",
	"Round and Round",
	"Crossing the Stream",
	"Navigating a Corner",
]

func get_instance():
	return moons[GS.moon_index].instance()
