extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scroll = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func calc_scroll():
	scroll = min(scroll, 0)
	margin_top = scroll

func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
	
			if event.button_index == BUTTON_WHEEL_UP:
				scroll += 50
				calc_scroll()
			if event.button_index == BUTTON_WHEEL_DOWN:
				scroll -= 50
				calc_scroll()

