extends KinematicBody2D


export var min_speed = 30;
export var max_speed = 50;
export var speed = 0
export var direction = Vector2.ZERO
export var knockback_force = 1000

onready var animationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	move_and_slide(direction * speed)
	animate(direction)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bouncer_body_entered(body):
	if body.state == body.playerState.ACTIVE:
		var knockback_vector = body.global_position - global_position
		body.knockback_vector = knockback_vector.normalized()
		body.change_to_stunned_state()

func animate(dir):
	if dir.x >= 0 :
		animationPlayer.play("move_right")
	else:
		animationPlayer.play("move_left")
	
