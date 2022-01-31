extends Node


export(int) var max_spawn_count = 5
export(Array, int) var x_range =[-1000, 1000]
export(Array, int) var y_range = [-1000, 1000]
var can_spawn = false

onready var spawnTimer = $SpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawnTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_spawn and get_child_count() < max_spawn_count:
		var pos = calculate_location()
		spawn(pos)
	

func spawn(location):
	var scene = preload("res://Scenes/Environment/FishingZone.tscn")
	var zone = scene.instance()
	add_child(zone)
	zone.position = location
	spawnTimer.start()

func calculate_location():
	var xloc = rand_range(x_range[0], x_range[1])
	var yloc = rand_range(y_range[0], y_range[1])
	var coords = Vector2(xloc, yloc)
	return coords

func _on_SpawnTimer_timeout():
	can_spawn = true;
