extends KinematicBody2D


export var min_speed = 10;
export var max_speed = 30;
export var speed = 0
export var direction = Vector2.ZERO
onready var cooldownTimer = $CooldownTimer
onready var attackCollider = $AttackRange/CollisionShape2D
onready var sprite = $YSort/AnimatedSprite
onready var audioPlayer = $AudioStreamPlayer

var introSounds = [preload("res://Assets/SFX/ahoy.wav"),
					preload("res://Assets/SFX/yoho.wav"),
					preload("res://Assets/SFX/yarr.wav")]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var rand = floor(rand_range(0, 1.99))
	audioPlayer.stream = introSounds[rand]
	audioPlayer.play()
	
func _physics_process(delta):
	if direction.x >= 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	move_and_slide(direction * speed)




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_AttackRange_body_entered(body):
	if GlobalVariables.fishCount - 15 < 0 :
		GlobalVariables.fishCount = 0
	else:
		GlobalVariables.fishCount -= 15
	attackCollider.disabled = true
	cooldownTimer.start()
	audioPlayer.stream = introSounds[2]
	audioPlayer.play()
	body.hurt()


func _on_CooldownTimer_timeout():
	attackCollider.disabled = false
