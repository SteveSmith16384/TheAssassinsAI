class_name Unit
extends Node2D

const SPEED = 1

onready var main = get_tree().get_root().get_node("Main")

export var side:int
var main_target # If seen, go ape!
var group = [] # Other friendly units

var route = []
var current_enemy
var alive = true

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive == false:
		return
		
	if current_enemy != null:
		if current_enemy.alive == false or main.is_in_line_of_sight(self, current_enemy) == false:
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
	# CHeck if any enemies can be seen
	for unit in main.units:
		if unit.side == self.side:
			continue
		if self.position.distance_to(unit.position) > 100:
			continue
		if main.is_in_line_of_sight(self, unit) == false:
			continue
		
		current_enemy = unit
		break
		#print("Can see")
	pass


func shoot():
	#todo
	pass
	


func _on_Area2D_Closeby_area_entered(area):
	var unit = area.get_parent()
	if unit.is_in_group("units") == false:
		return
	if unit.side == side:
		group.push_back(unit)
	pass


func _on_Area2D_Closeby_area_exited(area):
	var unit = area.get_parent()
	if unit.is_in_group("units") == false:
		return
	if unit.side == side:
		group.erase(unit)
	pass
