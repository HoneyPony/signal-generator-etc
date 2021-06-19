extends Node2D

onready var src1 = $Jack1/CableSrc
onready var src2 = $Jack2/CableSrc
onready var ssrc1 = $Jack1/CableSrc2
onready var ssrc2 = $Jack2/CableSrc2

var actual_draw_strength = 20
var actual_draw_width = 8

const W_MIN = 18
const W_MAX = 18

var drop_sign = 1

enum Mode {
	Spawn,
	Spawning,
	Normal
}

var cur_mode = Mode.Spawn

func _ready():
	visible = false
	$Jack1.paired_jack = $Jack2
	$Jack2.paired_jack = $Jack1

func _draw():
	var bezier: Curve2D = Curve2D.new()
	
	var dist = (src1.global_position - src2.global_position).length()
	var strength = dist * 0.3
	actual_draw_strength += (strength - actual_draw_strength) * 0.05
	
	var width = W_MIN + dist / 200.0
	width = clamp(width, W_MIN, W_MAX)
	
	actual_draw_width += (width - actual_draw_width) * 0.05
	
	var t1 = polar2cartesian(actual_draw_strength, src1.global_rotation)
	var t2 = polar2cartesian(actual_draw_strength, src2.global_rotation)

	var halfway = (src1.global_position + src2.global_position) / 2.0
	halfway.y = max(max(halfway.y, src1.global_position.y), src2.global_position.y)
	halfway.y += actual_draw_strength * 0.5
	
	var x_dist = abs(src1.global_position.x - src2.global_position.x)
	
	var drop_mul = x_dist * 0.2
	
	var st1 = t1.normalized() * 3
	var st2 = t2.normalized() * 3
	
	t1.y -= actual_draw_strength * 1.3
	t2.y -= actual_draw_strength * 1.3
	
	#bezier.add_point(ssrc1.global_position)#, st1, -st1)
	bezier.add_point(src1.global_position, t1, -t1)
	#bezier.add_point(halfway, Vector2(drop_mul * drop_sign, 0), Vector2(-drop_mul * drop_sign, 0))
	bezier.add_point(src2.global_position, -t2, t2)
	#bezier.add_point(ssrc2.global_position)#, -st2, st2)
	
	var points: PoolVector2Array = bezier.get_baked_points()
	
	
	var bezier2 = Curve2D.new()
	bezier2.add_point(src1.global_position + Vector2(0, -1), t1, -t1)
	#bezier2.add_point(halfway + Vector2(0, -1), Vector2(drop_mul * drop_sign, 0), Vector2(-drop_mul * drop_sign, 0))
	bezier2.add_point(src2.global_position + Vector2(0, -1), -t2, t2)
	
	
	var points2: PoolVector2Array = bezier2.get_baked_points()
	#points.push_back(src1.global_position)
	#points.push_back(src2.global_position)
	draw_polyline(points, Color.black, actual_draw_width, true)
	
	draw_polyline(points2, Color(0x1a1a1aff), actual_draw_width * 0.55, true)
	
var dist_down_from_camera = 0
	
func go_to_camera():
	var size = get_viewport().size
	
	var center_y = GS.camera.global_position.y - size.y * 0.5 * GS.camera_scale_inv
	
	var center_x = GS.camera.global_position.x
	
	#var dist = 300 * GS.camera_scale_inv
	
	dist_down_from_camera += (120 - dist_down_from_camera) * 0.05
	var dist_scale = dist_down_from_camera * GS.camera_scale_inv + 160
	
	$Jack1.global_position = Vector2(center_x, center_y + dist_scale)
	$Jack1.rotation_degrees = 90
	$Jack2.global_position = Vector2(center_x, center_y - 400)
	$Jack2.rotation_degrees = -90
	
func move_jack_two():
	var pos = $Jack1.global_position
	var dir = polar2cartesian(500, $Jack1.rotation)
	
	
	var target_pos = pos - dir
	$Jack2.global_position += (target_pos - $Jack2.global_position) * 0.05
	var target_rot = cartesian2polar(-dir.x, -dir.y).y
	$Jack2.rotation = lerp_angle($Jack2.rotation, target_rot, 0.05)
	
func advance_spawn_state(which):
	if which == $Jack1 and cur_mode == Mode.Spawn:
		cur_mode = Mode.Spawning

func _process(delta):
	
	if cur_mode == Mode.Spawn:
		visible = true
		z_index = 15
		go_to_camera()
		
	if cur_mode == Mode.Spawning:
		if $Jack1.dragging:
			z_index = 101
			move_jack_two()
		else:
			cur_mode = Mode.Normal
			
	if cur_mode == Mode.Normal:
		z_index = 101
		if GS.next_patch_cable == self:
			GS.next_patch_cable = null
			GS.may_spawn_patch_cable = true
	
	var drop_sign_target = 1
	
	if src1.global_position.x > src2.global_position.x:
		drop_sign_target = 1
	else:
		drop_sign_target = -1
		
	drop_sign += (drop_sign_target - drop_sign) * 0.05
	
	update()
