extends KinematicBody2D

var velocity = 128
var is_collided = false

func _process(delta):
	if is_collided:
		return
	
	var vel = velocity * delta * polar2cartesian(1, rotation)
	move_and_collide(vel)
