extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport.size = rect_size * 0.5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_size = rect_size
	target_size.x = get_parent().rect_size.x
	
	#rect_size.x = get_parent().rect_size.x
	$Viewport.size = target_size
	# Hack to get Godot to recalculate size or something...
	set_visible(false)
	call_deferred("set_visible", true)
	
	#print($Viewport.size, " VS ", rect_size, " - ", get_parent().rect_size)
