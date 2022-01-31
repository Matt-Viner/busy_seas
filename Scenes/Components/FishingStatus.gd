extends Node


enum FishingStates{
	NOT_FISHING,
	FISHING
}

var state = FishingStates.NOT_FISHING
var can_fish = true

onready var fishingTimer = $FishingTimer
onready var audioStream = $AudioStreamPlayer

func _ready():
	pass # Replace with function body.
	
func switch_state():
	match state:
		FishingStates.NOT_FISHING:
			state = FishingStates.FISHING
		FishingStates.FISHING:
			state = FishingStates.NOT_FISHING

func _physics_process(delta):
	match state:
		FishingStates.FISHING:
			if can_fish:
				start_fishing()
		FishingStates.NOT_FISHING:
				if fishingTimer.is_stopped() == false:
					fishingTimer.stop()
				if can_fish == false:
					can_fish = true

func start_fishing():
	fishingTimer.start()
	can_fish = false;


func _on_FishingTimer_timeout():
	GlobalVariables.fishCount += 10
	audioStream.play()
	can_fish = true
