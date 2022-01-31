extends Tween


# Declare member variables here. Examples:
export(Array, int) var tweenValues = [-5, 5]
export(String) var property = "rotation_degrees"
export(int) var duration = 1

onready var sprite = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	animate()

func animate():
	interpolate_property(sprite, property, tweenValues[0], tweenValues[1], duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	start()

func _on_AnimateTween_tween_completed(object, key):
	tweenValues.invert()
	animate()
