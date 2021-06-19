extends Node2D

#const radius = 20 / PI
const radius = 32 / PI

var left_motor_functioning = true
var right_motor_functioning = true

func _ready():
	GS.rover = self
	
	$RoverSmokeL.visible = false
	$RoverSmokeR.visible = false

func _process(delta):
	if GS.won_level:
		GS.run_rover = false
	
	if not GS.run_rover:
		return
	
	var forward = polar2cartesian(1, rotation)
	var sideways = polar2cartesian(1, rotation + PI / 2.0)
	
	if abs(GS.left_motor_power / 32.0) > 4.0:
		left_motor_functioning = false
		$RoverSmokeL.visible = true
	if abs(GS.right_motor_power / 32.0) > 4.0:
		right_motor_functioning = false
		$RoverSmokeR.visible = true
	
	var l_delta = GS.left_motor_power * delta * forward
	var r_delta = GS.right_motor_power * delta * forward
	
	if not left_motor_functioning:
		l_delta = Vector2.ZERO
	if not right_motor_functioning:
		r_delta = Vector2.ZERO
	
	var l_location = global_position + sideways * radius
	var r_location = global_position - sideways * radius
	
	l_location += l_delta
	r_location += r_delta
	
	global_position = (l_location + r_location) / 2
	
	var dif = l_location - r_location
	var angle = cartesian2polar(dif.x, dif.y).y - PI / 2.0
	
	#print(angle)
	#print(rotation)
	rotation = angle
	
	pass
