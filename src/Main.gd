extends Node2D

const unit_class = preload("res://Unit.tscn")

var units = []

func _ready():
	create_units()
	pass
	

func create_units():
	var unit1 = create_unit(1, Vector2(10, 10))
	var unit2 = create_unit(1, Vector2(20, 10))
	var unit3 = create_unit(1, Vector2(30, 10))
	var unit4 = create_unit(1, Vector2(40, 10))

	var unit10 = create_unit(2, Vector2(300, 300))
#	var unit = unit_class.instance()
#	unit.position = Vector2(10, 10)
#	unit.side = 1
#	self.add_child(unit)
#	units.push_back(unit)

#	unit = unit_class.instance()
#	unit.position = Vector2(360, 360)
#	unit.side = 2
#	self.add_child(unit)
#	units.push_back(unit)

	pass


func create_unit(side:int, pos:Vector2):
	var unit = unit_class.instance()
	unit.position = pos
	unit.side = side
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
			

