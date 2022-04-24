extends Node2D

const unit_class = preload("res://Unit.tscn")

var units = []

func _ready():
	create_units()
	pass
	

func create_units():
	var unit1 = create_unit(1, Globals.AI_Objective.FindSterner, Vector2(10, 10))
	var unit2 = create_unit(1, Globals.AI_Objective.FindSterner, Vector2(20, 10))
	var unit3 = create_unit(1, Globals.AI_Objective.FindSterner, Vector2(30, 10))
	var unit4 = create_unit(1, Globals.AI_Objective.FindSterner, Vector2(40, 10))

	var unit10 = create_unit(2, Globals.AI_Objective.DefendSterner, Vector2(200, 200))
	var unit11 = create_unit(2, Globals.AI_Objective.DefendSterner, Vector2(220, 220))
	var unit12 = create_unit(2, Globals.AI_Objective.DefendSterner, Vector2(220, 10))

	pass


func create_unit(side:int, objective, pos:Vector2):
	var unit = unit_class.instance()
	unit.position = pos
	unit.side = side
	unit.objective = objective
	self.add_child(unit)
	units.push_back(unit)
	return unit
	

func is_in_line_of_sight(from, thing):
	var space = get_world_2d().direct_space_state
	var line_of_sight_obstacle = space.intersect_ray(from.global_position, 
			thing.global_position, [from])
	
	if line_of_sight_obstacle.size() == 0 or line_of_sight_obstacle.collider == thing:
		return true
	else:
		return false
			

func get_final_dest():
	return $Map.get_final_dest()
	
