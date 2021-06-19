extends ColorRect

func _process(delta):
	visible = GS.won_level


func _on_NextMission_pressed():
	pass # Replace with function body.


func _on_Continue_pressed():
	pass # Replace with function body.


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
