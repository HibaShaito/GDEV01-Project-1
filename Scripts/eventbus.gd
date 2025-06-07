extends Node

signal playerHit
signal LevelFinished
signal GameOver

var levels=["res://Scenes/Level_1.tscn","res://Scenes/Level_2.tscn","res://Scenes/Level_3.tscn"]
var currentLevel=0

func _ready() -> void:
	LevelFinished.connect(nextLevel)
	GameOver.connect(gameOver)

func nextLevel():
	if currentLevel != 2:
		currentLevel+=1
		get_tree().change_scene_to_file.bind(levels[currentLevel]).call_deferred()
	else:
		get_tree().change_scene_to_file.bind("res://Scenes/main_menu.tscn").call_deferred()
		currentLevel=0

func gameOver():
	currentLevel=0
