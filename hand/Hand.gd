extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var is_in_game = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	global_position = get_global_mouse_position()
	
	if not is_in_game:
		return
	
	visible = GS.dragged_jack == null
