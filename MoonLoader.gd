extends Node

var Game = preload("res://Game.tscn")
var MissionSelect = preload("res://ui/MissionSelect.tscn")
var GameProxy = preload("res://LoadGameProxy.tscn")

var moons = [
	preload("res://moon/Moon0.tscn"),
	preload("res://moon/Moon1.tscn"),
	preload("res://moon/Moon2.tscn"),
	preload("res://moon/Moon3.tscn"),
	preload("res://moon/Moon4.tscn"),
	
	preload("res://moon/MoonHallMon.tscn"),
	preload("res://moon/MoonHallMonII.tscn"),
	
	preload("res://moon/MoonAntennaN.tscn"),
	
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
	
	"Navigating by Antenna",
	"Navigating by Sight",
]

func last_index():
	return moons.size() - 1

func get_instance():
	if GS.moon_index >= moons.size():
		GS.moon_index = moons.size() - 1
	
	return moons[GS.moon_index].instance()
