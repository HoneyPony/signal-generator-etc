extends Node2D

func _ready():
	pass 

var mouse = false

var dragging = false
var drag_center = Vector2.ZERO

var plug_target = null
var y_align_strength = 0
var x_align_strength = 0

var plug_coupling = null

var paired_jack = null

onready var internal_col = get_node("Area2D/InternalCol")

func _mouse_enter():
	#GS.enable_hover_count += 1
	mouse = true

func _mouse_exit():
	#GS.enable_hover_count -= 1
	mouse = false
	
func x_gte(x1, x2):
	var sgn = 1
	if plug_target != null:
		if plug_target.rotation != 0:
			sgn = -1
	return x1 * sgn >= x2 * sgn
	
func y_gte(y1, y2):
	var sgn = 1
	if plug_target != null:
		if polar2cartesian(1, plug_target.rotation).y < 1:
			sgn = -1
	return y1 * sgn >= y2 * sgn
	
#func calc_region():
#	if plug_target == null:
#		$jack.region_rect.size.x = 1103
#		return
#
#	if abs(polar2cartesian(1, rotation).y) > 0.01:
#		$jack.region_rect.size.x = 1103
#		return
#
#	var cut_x = plug_target.region_cutoff_x()
#	var width = abs($Cutoff.global_position.x - cut_x)
#	if width < 0 or width > 1103 / 8.0:
#		width = 1103 / 8.0
#	$jack.region_rect.size.x = width * 8.0
	
func connect_plug():
	if plug_target == null:
		return
		
	if plug_coupling != plug_target:
		$Plugin.play("Plug")
		$PlugS.pitch_scale = rand_range(0.95, 1.05)
		$PlugS.play()
		
		# mouse has to re-enter to connect again
		#mouse = false
		internal_col.disabled = true
		
		
	plug_coupling = plug_target
	plug_coupling.jack_coupling = self
	
func plug_is_x():
	var rot = polar2cartesian(1, plug_target.rotation)
	if abs(rot.y) < 0.5:
		return true
	return false
	
func deconnect_plug():
	if plug_coupling == null:
		return
	plug_coupling.jack_coupling = null
	plug_coupling = null
	
func end_drag():
	if GS.dragged_jack == self:
		GS.dragged_jack = null
		
		if GS.mark_jack_for_trash:
			if plug_coupling != null:
				deconnect_plug()
			
			get_parent().queue_free()
			
			Music.get_node("ModTrash").pitch_scale = rand_range(0.95, 1.05)
			Music.get_node("ModTrash").play()
		else:
			if plug_coupling == null:
				$Down.pitch_scale = rand_range(0.95, 1.05)
				$Down.play()
	
func _physics_process(delta):
	if GS.run_rover:
		end_drag()
	
	if polar2cartesian(1, rotation).x >= 0:
		$jack.flip_v = false
	else:
		$jack.flip_v = true
	
	if plug_coupling == null and plug_target != null:
		var dist = (plug_target.global_position.distance_to(global_position))
		if dist > 170:
			plug_target = null
	
	if plug_coupling == null:
		internal_col.disabled = false
	
	if plug_coupling != null and not is_instance_valid(plug_coupling):
		get_parent().queue_free()
		plug_coupling = null
		return
		
	if not is_instance_valid(plug_target):
		plug_target = null
	
	if plug_target == null:
		z_index = 100
	else:
		z_index = -10
		
	if get_parent().cur_mode == get_parent().Mode.Spawn:
		z_index = 14
	
	dragging = dragging and Input.is_action_pressed("mouse_click")
	
	if not dragging:
		end_drag()
		
	
	if dragging:
		
		var target_position = get_global_mouse_position()
		
		var direction = target_position - $Hotspot.global_position
		var direction_2 = Vector2(target_position.x - $Hotspot.global_position.x, 0)
		var target_rotation = rotation
		var target_y = null
		
		var target_x = null
		
		if direction.length_squared() > 0.001:
			target_rotation = cartesian2polar(direction.x, direction.y).y
			
		#if direction_2.length_squared() > 0.001:
		#	var tr = cartesian2polar(direction_2.x, direction_2.y).y
		#	target_rotation = lerp_angle(target_rotation, tr, 0.6)
		
		var angl_strength = 0.2
		if direction.length_squared() < 16:
			angl_strength = 0.01
		
		if plug_target != null:
			if plug_is_x():
				target_rotation = plug_target.rotation
				target_y = plug_target.global_position.y
				y_align_strength = clamp(y_align_strength + 5 * delta, 0, 1)
				angl_strength = 0.5
				
				if abs(target_y - global_position.y) > 10:
					angl_strength = 0.1
			else:
				target_rotation = plug_target.rotation
				target_x = plug_target.global_position.x
				x_align_strength = clamp(x_align_strength + 5 * delta, 0, 1)
				angl_strength = 0.5
				
				if abs(target_x - global_position.x) > 10:
					angl_strength = 0.1
		else:
			y_align_strength = 0
			x_align_strength = 0
		
		rotation = lerp_angle(rotation, target_rotation, angl_strength)
		
		var dif_needed = target_position - $Hotspot.global_position
		position += dif_needed
		if plug_target != null:
			if plug_is_x():
				var p1 = plug_target.push_x_1()
				var p2 = plug_target.push_x_2()
				if x_gte(position.x, p1) and not x_gte(position.x, p2):
					var dif = position.x - p1
					position.x = p1 + dif * 0.4
				
				if x_gte(position.x, p1):
					y_align_strength = 1.0
				
				if x_gte(position.x, plug_target.max_x()):
					position.x = plug_target.max_x()
					connect_plug()
				else:
					deconnect_plug()
				
				# if we aren't lined up in rotation yet, don't go in
				if abs(polar2cartesian(1, rotation).y) > 0.01:
					if x_gte(position.x, plug_target.max_unaligned_x()):
						position.x = lerp(position.x, plug_target.max_unaligned_x(), 0.8)
			else:
				var p1 = plug_target.push_y_1()
				var p2 = plug_target.push_y_2()
				if y_gte(position.y, p1) and not y_gte(position.y, p2):
					var dif = position.y - p1
					position.y = p1 + dif * 0.4
				
				if y_gte(position.y, p1):
					y_align_strength = 1.0
				
				if y_gte(position.y, plug_target.max_y()):
					position.y = plug_target.max_y()
					connect_plug()
				else:
					deconnect_plug()
				
				# if we aren't lined up in rotation yet, don't go in
#				if abs(polar2cartesian(1, rotation).y) > 0.01:
#					if x_gte(position.x, plug_target.max_unaligned_x()):
#						position.x = lerp(position.x, plug_target.max_unaligned_x(), 0.8)

		if target_y != null:
			global_position.y = lerp(global_position.y, target_y, y_align_strength)
		
		if target_x != null:
			global_position.x = lerp(global_position.x, target_x, x_align_strength)
		
		
		#$jack_cover.flip_v = $jack.flip_v
		
		$jack.modulate = Color.white
		#calc_region()
		return
	else:
		if plug_coupling != null:
			if plug_is_x():
				global_position.y = plug_coupling.global_position.y
				global_position.x = plug_coupling.max_x()
			else:
				global_position.x = plug_coupling.global_position.x
				global_position.y = plug_coupling.max_y()
			
		
	#calc_region()
		
	
	if mouse:
		$jack.modulate = Color(0.5, 1.0, 0.5, 1.0)
		
		if Input.is_action_just_pressed("mouse_click"):
			if not GS.run_rover:
			
				if GS.dragged_jack == null and GS.dragged_misc == null:
					if GS.dragged_module != null:
						GS.dragged_module.end_drag()
					
					
					GS.dragged_jack = self
					dragging = true
					
					get_parent().advance_spawn_state(self)
					
					$Up.pitch_scale = rand_range(0.95, 1.05)
					$Up.play()
					
					#drag_center = get_global_mouse_position() - global_position
					$Hotspot.global_position = get_global_mouse_position()
	else:
		$jack.modulate = Color.white
