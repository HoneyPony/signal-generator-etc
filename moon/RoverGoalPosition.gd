extends Sprite

onready var camera = get_node("../Camera2D")

func _process(delta):
	var mod_target = 1.0
	if camera.zoom_fac >= 2:
		mod_target = 0.0
		
	$get_rover_here.modulate.a += (mod_target - $get_rover_here.modulate.a) * 0.1
		
	
	var radius = GS.rover.global_position.distance_to(global_position)
	
	if radius <= 3:
		GS.won_level = true
	#GS.won_level = true
