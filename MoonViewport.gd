extends Viewport

var loaded_moon = null

func _ready():
	reload_moon()
	
func reload_moon():
	if loaded_moon != null:
		loaded_moon.queue_free()
		loaded_moon = null
		
	loaded_moon = MoonLoader.get_instance()
	add_child(loaded_moon)
	
	update_worlds()
