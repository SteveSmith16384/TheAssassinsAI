extends Node2D

const unit_class = preload("res://Unit.tscn")

var game_over = false

var units = []
var sterner

func _ready():
	$Map.load_map()
	create_units()
	pass
	

func create_units():
	# Side 2
	sterner = create_unit(2, Globals.AI_Objective.DefendSterner, $Map.get_deploy_sq(2))
	sterner.get_node("Sprite_white").visible = true
	var unit11 = create_unit(2, Globals.AI_Objective.DefendSterner, $Map.get_deploy_sq(2))
	unit11.get_node("Sprite_red").visible = true
	var unit12 = create_unit(2, Globals.AI_Objective.DefendSterner, $Map.get_deploy_sq(2))
	unit12.get_node("Sprite_red").visible = true
	var unit13 = create_unit(2, Globals.AI_Objective.DefendSterner, $Map.get_deploy_sq(2))
	unit13.get_node("Sprite_red").visible = true
	var unit14 = create_unit(2, Globals.AI_Objective.DefendSterner, $Map.get_deploy_sq(2))
	unit14.get_node("Sprite_red").visible = true
	var unit15 = create_unit(2, Globals.AI_Objective.DefendSterner, $Map.get_deploy_sq(2))
	unit15.get_node("Sprite_red").visible = true
	var unit16 = create_unit(2, Globals.AI_Objective.DefendSterner, $Map.get_deploy_sq(2))
	unit16.get_node("Sprite_red").visible = true

	# Side 1
	var unit1 = create_unit(1, Globals.AI_Objective.FindSterner, $Map.get_deploy_sq(1))
	unit1.get_node("Sprite_green").visible = true
	var unit2 = create_unit(1, Globals.AI_Objective.FindSterner, $Map.get_deploy_sq(1))
	unit2.get_node("Sprite_green").visible = true
	var unit3 = create_unit(1, Globals.AI_Objective.FindSterner, $Map.get_deploy_sq(1))
	unit3.get_node("Sprite_green").visible = true
	var unit4 = create_unit(1, Globals.AI_Objective.FindSterner, $Map.get_deploy_sq(1))
	unit4.get_node("Sprite_green").visible = true
	var unit5 = create_unit(1, Globals.AI_Objective.FindSterner, $Map.get_deploy_sq(1))
	unit5.get_node("Sprite_green").visible = true
	unit1.main_target = sterner
	unit2.main_target = sterner
	unit3.main_target = sterner
	unit4.main_target = sterner
	unit5.main_target = sterner
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
	
	return line_of_sight_obstacle.size() == 0 or line_of_sight_obstacle.collider == thing


func get_final_dest():
	return $Map.get_final_dest()
	

func unit_died(unit):
	if unit == sterner:
		game_over = true
		pass
	pass
	
