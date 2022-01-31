extends Node2D

onready var sceneTransition = $CanvasLayer/SceneTransitionRect
onready var maxScoreLabel = $CanvasLayer/MaxScoreLabel
onready var yourScoreLabel = $CanvasLayer/YourScoreLabel
onready var audioStream = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalVariables.fishCount > GlobalVariables.MaxScore:
		GlobalVariables.MaxScore = GlobalVariables.fishCount
	
	maxScoreLabel.text = "Max Score:    " + str(GlobalVariables.MaxScore)
	yourScoreLabel.text = "Your Score:    " + str(GlobalVariables.fishCount)
	
	play_audio()
	

func play_audio():
	audioStream.play()

func _on_Button_pressed():
	GlobalVariables.fishCount = 0
	sceneTransition.transition_to()


func _on_AudioStreamPlayer_finished():
	play_audio()
