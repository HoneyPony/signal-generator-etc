extends Node

const MENU = 0
const MAIN = 1

var cur_music = -1

onready var musics = [
	$Menu,
	$Main
]

func play(what):
	if what == cur_music:
		return
		
	if cur_music >= 0:
		musics[cur_music].stop()
		
	cur_music = what
	musics[cur_music].play()

func _ready():
	play(MENU)
