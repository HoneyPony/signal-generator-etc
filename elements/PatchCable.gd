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

func _ready():
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
	
	

func _process(delta):
	var drop_sign_target = 1
	
	if src1.global_position.x > src2.global_position.x:
		drop_sign_target = 1
	else:
		drop_sign_target = -1
		
	drop_sign += (drop_sign_target - drop_sign) * 0.05
	
	update()
