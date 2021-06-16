extends Node2D

var visited_this_frame = false

func _ready():
	add_to_group("Modules")

func get_inputs():
	return []

func mod_process(delta):
	pass
	
func boolstate(num):
	return abs(num) > 0.02
