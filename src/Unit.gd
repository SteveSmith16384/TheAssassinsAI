extends Node2D

const SPEED = 2

onready var main = get_tree().get_root().get_node("Main")

export var side:int
var main_target # If seen, go ape!
var squad = [] # Other friendly units

var route = []
var current_enemy
var alive = true

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_enemy != null:
		if current_enemy.alive == false or is_in_line_of_sight(current_enemy):
			current_enemy = null
		else:
			shoot()
		return
		
	if route.empty():
		var dest = Vector2(200, 200)
		route = Globals.get_route(self.position, dest)
	else:
		var dest:Vector2 = route[0]
		if dest.distance_to(self.position) < 3:
			route.remove(0)
		else:
			var diff = (dest - self.position).normalized() * SPEED
			self.position += diff
	pass


func _on_Timer_CheckForEnemies_timeout():
	for unit in main.units:
		if unit.side == self.side:
			continue
		if self.position.distance_to(unit.position) > 100:
			continue
		if is_in_line_of_sight(unit) == false:
			continue
		print("Can see")
	pass


func is_in_line_of_sight(thing):
	var space = get_world_2d().direct_space_state
	var line_of_sight_obstacle = space.intersect_ray(global_position, 
			thing.global_position, [self])
	
	if line_of_sight_obstacle.size() == 0 or line_of_sight_obstacle.collider == thing:
		return true
	else:
		return false
			

func shoot():
	#todo
	pass
	
