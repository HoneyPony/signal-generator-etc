extends ColorRect

export var count = 9


var scroll = 0
var max_scroll = 0

var part_arr = []

func _ready():
	part_arr.resize(count)
	
	for i in get_child_count():
		var c: Control = get_child(i)
		
		var index = int(c.rect_position.y / 200)
		part_arr[index] = c
		
func avail_height():
	return get_viewport().size.y - 76 - 16
		
func layout_parts():
	var columns = 1
	var width = rect_size.x
	
	if width >= 400:
		columns = 2
		
	var margin = (width - (columns * 200)) * 0.5
	
	var column_number = 0
	var row_number = 0
	
	for p in part_arr:
		p.rect_position = Vector2(margin + column_number * 200, row_number * 200)
		
		column_number += 1
		if column_number >= columns:
			column_number = 0
			row_number += 1
			
	max_scroll = ((row_number) * 200) - avail_height()# - rect_size.y
	max_scroll = max(max_scroll, 0)

func calc_scroll():
	scroll = clamp(scroll, -max_scroll, 0)
	margin_top = scroll
	
func _process(delta):
	if scroll < -max_scroll:
		calc_scroll()
	
	layout_parts()

func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
	
			if event.button_index == BUTTON_WHEEL_UP:
				scroll += 50
				calc_scroll()
			if event.button_index == BUTTON_WHEEL_DOWN:
				scroll -= 50
				calc_scroll()

