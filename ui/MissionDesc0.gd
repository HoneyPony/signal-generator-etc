extends Label

export var index = -1

func _process(delta):
	if GS.tut_index > index:
		if GS.tut_index < 7:
			hide()
		
	if GS.tut_index >= 0 && GS.tut_index == index:
		show()
