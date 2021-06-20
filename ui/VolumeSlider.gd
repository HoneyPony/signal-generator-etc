extends HSlider


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var bus_name = "Master"

var bus = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	bus = AudioServer.get_bus_index(bus_name)
	
	value = db2linear(AudioServer.get_bus_volume_db(bus))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	AudioServer.set_bus_volume_db(bus, linear2db(value))
