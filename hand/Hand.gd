extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var is_in_game = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

onready var hands = [
	$Def,
	$HoverDrag
]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position = get_global_mouse_position()
	
	if not is_in_game:
		for h in hands:
			h.visible = false
		$Def.visible = true
		return
	
	visible = GS.dragged_jack == null
	
	var index = 0
	
	if GS.enable_hover_count > 0:
		index = 1
		
	for i in range(0, hands.size()):
		hands[i].visible = (i == index)
