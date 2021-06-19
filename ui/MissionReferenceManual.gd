extends ColorRect

onready var descriptions = [
	null,
	$MissionDesc1,
	$MissionDesc2,
	$MissionDesc3,
	$MissionDesc4
]

func _ready():
	$MRMLabel.text = "Mission Reference Manual: \"" + MoonLoader.titles[GS.moon_index] + "\""
	
	descriptions[GS.moon_index].show()
