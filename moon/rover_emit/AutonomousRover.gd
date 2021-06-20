extends KinematicBody2D

var velocity = 128
var is_collided = false

func is_in_front(bod: Node2D):
	var dir_vector = polar2cartesian(1, rotation)
	var dir_to_bod = bod.global_position - global_position
	
	var forward_comp = dir_to_bod.project(dir_vector).length()
	
	#print(forward_comp)
	
	if forward_comp >= 64:
		return true

	return false

func read_sensor(s: Area2D):
	var bods = s.get_overlapping_bodies()
	var state = false
	
#	if bods.size() > 1:
#		print("size > 1")
	
	for b in bods:
		if b.is_in_group("AMRover"):
			if b != self:
				if is_in_front(b):
#				print("got another rover")
					state = true
				
#	bods = s.get_overlapping_areas()
#
#	for b in bods:
#		if b.is_in_group("AMRover"):
#			if b != self:
##				print("got another rover")
#				state = true
	
	return state

func _process(delta):
	if is_collided:
		return
	
	var vel = velocity * delta * polar2cartesian(1, rotation)
	
	if read_sensor($FrontSensor):
#		print("GSDJFLSKDFs")
		vel = Vector2.ZERO
	
	move_and_collide(vel)
