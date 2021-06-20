extends ColorRect

func _ready():
	hide()
	
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		
	visible = get_tree().paused

func _on_Continue_pressed():
	get_tree().paused = false


func _on_BackToMenu_pressed():
	
	#GS.reset_state()
	get_tree().change_scene_to(MoonLoader.MissionSelect)
	get_tree().paused = false
