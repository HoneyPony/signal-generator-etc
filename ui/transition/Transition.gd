extends Sprite

func _ready():
	GS.transition = self
	if GS.has_loaded_a_scene:
		get_node("../In").play()
	else:
		$Anim.play("Immediate")
		GS.has_loaded_a_scene = true
	
func _exit_tree():
	GS.transition = null
	
var target_scene = null
	
func transition_to(scene):
	target_scene = scene
	$Anim.play("Out")
	get_node("../Out").play()

func out_done():
	if target_scene != null:
		get_tree().change_scene_to(target_scene)
		
func _process(delta):
	var needed_size = get_viewport().size
	needed_size.x *= 19
	
	region_rect.size = needed_size
