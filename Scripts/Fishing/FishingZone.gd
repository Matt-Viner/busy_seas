extends Area2D

onready var randomTimer = $RandomTimer
onready var animationPlayer = $AnimationPlayer
var timer_length

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	timer_length = rand_range(2, 4)
	randomTimer.wait_time = timer_length

func _on_FishingZone_body_entered(body):
	var fishingStatus = body.get_node("FishingStatus")
	fishingStatus.switch_state()


func _on_FishingZone_body_exited(body):
	var fishingStatus = body.get_node("FishingStatus")
	fishingStatus.switch_state()


func _on_RandomTimer_timeout():
	animationPlayer.play("fade_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		randomTimer.start()
	if anim_name == "fade_out":
		queue_free()

