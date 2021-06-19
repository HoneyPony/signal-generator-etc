extends ColorRect

onready var descriptions = [
	$MissionDesc0
]

func _ready():
	$MRMLabel.text = "Mission Reference Manual: \"" + MoonLoader.titles[GS.moon_index] + "\""
	
	descriptions[GS.moon_index].show()
