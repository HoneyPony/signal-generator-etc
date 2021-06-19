extends KinematicBody2D

var velocity = 128
var is_collided = false

func read_sensor(s: Area2D):
	var bods = s.get_overlapping_bodies()
	var state = false
	
	if bods.size() > 1:
		print("size > 1")
	
	for b in bods:
		if b.is_in_group("AMRover"):
			if b != self:
				print("got another rover")
				state = true
	
	return state

func _process(delta):
	if is_collided:
		return
	
	var vel = velocity * delta * polar2cartesian(1, rotation)
	
	if read_sensor($FrontSensor):
		print("GSDJFLSKDFs")
		vel = Vector2.ZERO
	
	move_and_collide(vel)
