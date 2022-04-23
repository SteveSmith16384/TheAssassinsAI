extends Node

const VERSION = "0.1"
const RELEASE_MODE = false

# Debug settings
#const SHOW_FPS = true and !RELEASE_MODE

const MAP_SIZE:int = 40
const SQ_SIZE:int = 10

var astar : AStar2D

var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

func get_route(start:Vector2, end:Vector2):
	var id_from = astar.get_closest_point(start)
	var id_to = astar.get_closest_point(end)
	return astar.get_point_path(id_from, id_to)
	
	
