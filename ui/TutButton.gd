extends Button

export var index = 0

var TutPanel = preload("res://ui/TutInfoPanel.gd")

func _ready():
	var p = get_parent()
	if p is TutPanel:
		index = p.index

func _on_TutButton_pressed():
	if GS.tut_index == index:
		GS.tut_index += 1
