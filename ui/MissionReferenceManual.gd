extends ColorRect

onready var descriptions = [
	$MissionDesc0_0,
	$MissionDesc1,
	$MissionDesc2,
	$MissionDesc3,
	$MissionDesc4,
	$MissionDescHMI,
	$MissionDescHMII,
	$MissionDescSensN
]

func _ready():
	$MRMLabel.text = "Mission Reference Manual: \"" + MoonLoader.titles[GS.moon_index] + "\""
	
	var desc: Label = descriptions[GS.moon_index]
	desc.show()
	
	var handle = get_node("../TextureRect")
	
	var height = desc.rect_size.y + 32 + 40 + 80
	
	handle.target_override = get_viewport().size.y - height
