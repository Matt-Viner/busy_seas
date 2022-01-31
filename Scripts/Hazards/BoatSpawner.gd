extends YSort

var max_spawn_count = 20
export(Array, int) var x_range =[-1000, 1000]
export(Array, int) var y_range = [-1000, 1000]

onready var spawnTimer = $SpawnTimer
onready var pirateSpawnTimer = $PirateTimer
onready var boatSpawnLocation = $BoatSpawn/BoatSpawnLocation


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawnTimer.start()
	pirateSpawnTimer.start()


func _on_SpawnTimer_timeout():
	if get_child_count() < max_spawn_count:
		boatSpawnLocation.offset = randi()
		
		var scene = preload("res://Scenes/Environment/PassengerBoat.tscn")
		var boat = scene.instance()
		
		add_child(boat)
		
		var angle = boatSpawnLocation.rotation + PI/2 + rand_range(-PI/4, PI/4)
		var direction = Vector2(cos(angle), sin(angle))
		boat.position = boatSpawnLocation.position	
		boat.speed = rand_range(boat.min_speed, boat.max_speed)
		boat.direction = direction
	
	
	


func _on_PirateTimer_timeout():
	boatSpawnLocation.offset = randi()
	var scene = preload("res://Scenes/Environment/PirateBoat.tscn")
	var pirate = scene.instance()
	
	add_child(pirate)
	
	var angle = boatSpawnLocation.rotation + PI/2 + rand_range(-PI/4, PI/4)
	var direction = Vector2(cos(angle), sin(angle))
	# Set the mob's position to a random location.
	pirate.position = boatSpawnLocation.position
	pirate.speed = rand_range(pirate.min_speed, pirate.max_speed)
	pirate.direction = direction
