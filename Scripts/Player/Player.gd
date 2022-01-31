extends KinematicBody2D


enum playerState {
	ACTIVE,
	STUNNED
}

var state = playerState.ACTIVE


const ACCELERATION = 150
const MAX_SPEED = 80
const FRICTION = 150
const KNOCKBACK_FORCE = 100

var velocity = Vector2.ZERO
var fish = 0

var knockback_vector = Vector2.ZERO

export(Array, int) var max_position = [1000, 1000]

onready var boatSprite = $Boat
onready var fishingStatus = $FishingStatus
onready var stunnedTimer = $StunnedTimer
onready var flashAnim = $Flasher
onready var audioPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		playerState.ACTIVE:
			moveState(delta)
		playerState.STUNNED:
			stunnedState(delta)
	
	move()
	
	position.x = clamp(position.x, 16, max_position[0] - 16)
	position.y = clamp(position.y, 16, max_position[1] - 16)


func moveState(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputVector = inputVector.normalized()
	if inputVector.x < 0 :
		boatSprite.flip_h = true
	elif inputVector.x > 0:
		boatSprite.flip_h = false
	if inputVector != Vector2.ZERO:
		velocity = velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func stunnedState(delta):
	velocity = velocity.move_toward(knockback_vector * KNOCKBACK_FORCE, KNOCKBACK_FORCE * KNOCKBACK_FORCE * delta)

func change_to_stunned_state():
	state = playerState.STUNNED
	hurt()
	stunnedTimer.start()

func hurt():
	flashAnim.play("flashing")
	audioPlayer.play()


func move():
	velocity = move_and_slide(velocity)


func _on_StunnedTimer_timeout():
	state = playerState.ACTIVE
	knockback_vector = Vector2.ZERO
