extends Control

export var part_scene: PackedScene

onready var part_parent = get_node("../../../../../../")

onready var part_drag_layer = get_node("../../../../../../PartMoveLayer")

func spawn_part():
	if GS.dragged_jack != null:
		return
	if GS.dragged_module != null:
		return
	if GS.dragged_misc != null:
		return
		
	var pos = part_parent.get_global_mouse_position()
		
	var part = part_scene.instance()
	part.global_position = pos
	
	part_parent.add_child(part)
	
	
	
	var mod_drag = part.get_node("ModuleDragger")
	mod_drag.initialize(part_parent, part_drag_layer, pos)

func _on_Control_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				spawn_part()


func _on_Control_mouse_entered():
	#color.a = 1
	self_modulate = Color(0xadadadff)
	#self_modulate.a = 1
	
	


func _on_Control_mouse_exited():
	self_modulate.a = 0
	#color.a = 0

func _ready():
	self_modulate.a = 0
