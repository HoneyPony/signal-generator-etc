extends Sprite

func _ready():
	GS.transition = self
	
func _exit_tree():
	GS.transition = null
	
var target_scene = null
	
func transition_to(scene):
	target_scene = scene
	$Anim.play("Out")

func out_done():
	if target_scene != null:
		get_tree().change_scene_to(target_scene)
		
func _process(delta):
	var needed_size = get_viewport().size
	needed_size.x *= 19
	
	region_rect.size = needed_size
