extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var topLeftLimit = $Limits/TLLimit
onready var bottomRightLimit = $Limits/BRLimit
onready var fishingZoneSpawner = $FishingZoneSpawner
onready var player = $YSort/Player
onready var camera = $Camera2D
onready var gameTimer = $GameTimer
onready var timeLabel = $CanvasLayer/TimeLabel
onready var scoreLabel = $CanvasLayer/ScoreLabel
onready var sceneTransition = $CanvasLayer/SceneTransitionRect
onready var gameOverAudioPlayer = $GameOverSound
onready var bgmAudioPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var topLeftPosition = topLeftLimit.position
	var bottomRightPosition = bottomRightLimit.position
	
	camera.limit_left = topLeftPosition.x
	camera.limit_right = bottomRightPosition.x
	camera.limit_top = topLeftPosition.y
	camera.limit_bottom = bottomRightPosition.y
	
	fishingZoneSpawner.x_range = [topLeftPosition.x, bottomRightPosition.x]
	fishingZoneSpawner.y_range = [topLeftPosition.y, bottomRightPosition.y]
	
	player.max_position = [bottomRightPosition.x, bottomRightPosition.y]
	
	play_bgm()
	
	gameTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_time_display()
	update_score_display()

func update_time_display():
	timeLabel.text = str(floor(gameTimer.time_left))

func update_score_display():
	scoreLabel.text = str(GlobalVariables.fishCount)


func _on_GameTimer_timeout():
	gameOverAudioPlayer.play()
	sceneTransition.transition_to()

func play_bgm():
	bgmAudioPlayer.play()


func _on_AudioStreamPlayer_finished():
	play_bgm()
