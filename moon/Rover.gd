extends KinematicBody2D

#const radius = 20 / PI
const radius = 128 / PI

var left_motor_functioning = true
var right_motor_functioning = true

var is_collided = false

func _ready():
	GS.rover = self
	
	$RoverSmokeL.visible = false
	$RoverSmokeR.visible = false
	$ColSmoke.visible = false
	
func collide_rover():
	is_collided = true
	$ColSmoke.visible = true
	
	GS.mission_status_label.text = "Mission failed! Rover has collided with another rover"

func read_sensor(s: Area2D):
	var b = s.get_overlapping_bodies()
	var state = 0.0
	if not b.empty():
		state = 1.0
	return state
	
var disable_90_rounding = false

func _physics_process(delta):
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
	
	GS.rover_sensor_front = read_sensor($FrontSensor)


func _on_CollisionWithRover_body_entered(body):
	if body.is_in_group("ARover"):
		collide_rover()
		
		body.is_collided = true
