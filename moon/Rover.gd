extends KinematicBody2D

#const radius = 20 / PI
const radius = 128 / PI

var left_motor_functioning = true
var right_motor_functioning = true

var is_collided = false

func _ready():
	GS.rover = self
	
	GS.left_motor_power = 0.0
	GS.right_motor_power = 0.0
	
	GS.rover_sensor_front = false
	GS.rover_sensor_left = false
	GS.rover_sensor_right = false
	GS.rover_sensor_front_rock = false
	GS.rover_sensor_left_rock = false
	GS.rover_sensor_right_rock = false
	
	for i in range(0, 4):
		GS.antenna_out[i] = 0.0
		GS.antenna_exp[i] = false
	
	
	$RoverSmokeL.visible = false
	$RoverSmokeR.visible = false
	$ColSmoke.visible = false
	
func collide_rover():
	is_collided = true
	$ColSmoke.visible = true
	
	GS.mission_status_label.text = "Mission failed! Rover has collided with another rover"

func is_in_front(bod: Node2D, angle, p = false):
	var dir_vector = polar2cartesian(1, rotation + deg2rad(angle))
	var dir_to_bod = bod.global_position - global_position
	
	var forward_comp = dir_to_bod.project(dir_vector).length()
	
	if p:
		print(forward_comp)
	#print(forward_comp)
	
	if forward_comp >= 63.8:
		return true

	return false

func read_sensor(s, a, p = false):
	var b = s.get_overlapping_bodies()
	var state = false #0.0
	if not b.empty():
		for bod in b:
			if is_in_front(bod, a, p):
				state = true #1.0
	return state
	
func read_rock_s(s):
	var state = false
	
	var b = s.get_overlapping_bodies()
	if not b.empty():
		state = true 
				
	return state
	
var disable_90_rounding = false

func _physics_process(delta):
	GS.rover_sensor_front = read_sensor($FrontSensor, 0)
	GS.rover_sensor_left = read_sensor($LeftSensor, -90)
	GS.rover_sensor_right = read_sensor($RightSensor, 90)
	GS.rover_sensor_front_rock = read_rock_s($FrontRockSensor)
	GS.rover_sensor_left_rock = read_rock_s($LeftRockSensor)
	GS.rover_sensor_right_rock = read_rock_s($RightRockSensor)
	
	if GS.won_level:
		GS.run_rover = false
	
	if not GS.run_rover:
		return
		
	if is_collided:
		return
		
	var snap_90 = round(rotation_degrees / 90) * 90
	if abs(rotation_degrees - snap_90) < 2.5:
		if not disable_90_rounding:
			rotation_degrees = snap_90
		disable_90_rounding = true
	else:
		disable_90_rounding = false
	
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
	
	var calc_global_position = (l_location + r_location) / 2
	
	var last_angle = rotation
	
	var dif = l_location - r_location
	var angle = cartesian2polar(dif.x, dif.y).y - PI / 2.0
	
	
#	var angle_15 = round(angle_deg / 15.0) * 15.0
#	if abs(angle_deg - angle_15) < 0.05:
#		angle_deg = angle_15
		
#	var angle_90 = round(angle_deg / 90.0) * 90.0
#	if abs(angle_deg - angle_90) < 0.8:
#		angle_deg = angle_90
	
	#print(angle)
	#print(rotation)
	#rotation_degrees = angle_deg
	rotation = angle
	
	if abs(last_angle - rotation) < 0.005:
		disable_90_rounding = false
	
	var needed_vel = (calc_global_position - global_position)
	move_and_collide(needed_vel)
	
	#GS.rover_sensor_front = read_front_sensor()
	#read_front_sensor()
	#read_front_rocks()
	
	
#	print(GS.rover_sensor_right)

func _on_CollisionWithRover_body_entered(body):
	if body.is_in_group("ARover"):
		collide_rover()
		
		body.is_collided = true
