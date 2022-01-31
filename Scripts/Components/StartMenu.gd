extends Node2D


onready var sceneTransition = $CanvasLayer/SceneTransitionRect
onready var audioPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	start_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	sceneTransition.transition_to()

func start_music():
	audioPlayer.play()

func _on_AudioStreamPlayer_finished():
	start_music()
