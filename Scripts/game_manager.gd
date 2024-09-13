extends Node

class_name GameManager

@onready var bird: Bird = $"../Bird"
@onready var ground: Ground = $"../Ground"
@onready var pipe_spawner: PipeSpawner = $"../PipeSpawner"
@onready var fade: Fade = $"../Fade"
@onready var ui: Ui = $"../UI"


var points = 0

func _ready():
	pipe_spawner.bird_crashed.connect(on_end_game)
	ground.bird_crashed.connect(on_end_game)
	pipe_spawner.point_scored.connect(on_point_scored)

func on_end_game():
	if fade != null:
		fade.play()
	bird.kill()
	ground.stop()
	pipe_spawner.stop()
	ui.on_game_over()

func on_point_scored():
	points += 1
	ui.update_points(points)
