extends Node

var Game = preload("res://Game.tscn")
var MissionSelect = preload("res://ui/MissionSelect.tscn")

var moons = [
	preload("res://moon/Moon0.tscn"),
	preload("res://moon/Moon1.tscn"),
	preload("res://moon/Moon2.tscn"),
	preload("res://moon/Moon3.tscn"),
	preload("res://moon/Moon4.tscn"),
	
	preload("res://moon/MoonHallMon.tscn"),
	preload("res://moon/MoonHallMonII.tscn"),
	
	preload("res://moon/MoonSensorN.tscn"),
]

var titles = [
	"Welcome Aboard",
	"Straight to the Point",
	"Round and Round",
	"Crossing the Stream",
	"Navigating a Corner",
	
	"Hall Monitor",
	"Hall Monitor II",
	
	"Navigating by Sight",
]

func get_instance():
	return moons[GS.moon_index].instance()
