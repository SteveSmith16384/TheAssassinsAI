class_name Unit
extends Node2D

const SPEED = 30
const bullet_cls = preload("res://Bullet.tscn")

onready var main = get_tree().get_root().get_node("Main")

export var side:int
var objective
var main_target # Probably Sterner
var group = [] # Other friendly units

var route = []
var current_enemy
var alive = true
var shot_timer:float = 0
var final_dest #  When looking for Sterner

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main.game_over:
		return
		
	if alive == false:
		return
		
	shot_timer -= delta
	if current_enemy != null:
		if current_enemy.alive == false or main.is_in_line_of_sight(self, current_enemy) == false:
			current_enemy = null
		else:
			if shot_timer <= 0:
				shoot(current_enemy)
				shot_timer = 1
		return
		
	if route.empty():
		if objective == Globals.AI_Objective.FindSterner:
			final_dest = get_final_dest()
			route = Globals.get_route(self.position, final_dest)
		elif objective == Globals.AI_Objective.DefendSterner:
			# todo
			pass
	else:
		var target:Vector2 = route[0]
		if target.distance_to(self.position) < 3:
			route.remove(0)
		else:
			var diff = (target - self.global_position).normalized() * SPEED * delta
			self.position += diff
	pass


func get_final_dest():
	return main.get_final_dest()
	
	
func _on_Timer_CheckForEnemies_timeout():
	if main.game_over:
		return
		
	if current_enemy != null:
		return
		
	for unit in main.units:
		if unit.side == self.side:
			continue
		if unit.alive == false:
			continue
		if self.global_position.distance_to(unit.global_position) > 100:
			continue
		if main.is_in_line_of_sight(self, unit) == false:
			continue
		
		current_enemy = unit
		if side == 1 and unit == main_target:
			tell_others(main_target.global_position)
			break
		elif side == 2:
			tell_others(unit.global_position)
	pass


func tell_others(pos:Vector2):
	for unit in main.units: # todo - go through group?
		if unit.side != self.side:
			continue
		if unit.alive == false:
			continue
		if unit == main.sterner:
			continue
		unit.come_here(pos)
	pass
	

func come_here(pos:Vector2):
	if side == 1 and current_enemy != main_target:
		current_enemy = null
	route = Globals.get_route(self.position, pos)
	pass
	
	
func shoot(target):
	var bullet = bullet_cls.instance()
	bullet.shooter = self
	bullet.position = self.global_position
	var diff: Vector2 = (target.global_position - self.global_position).normalized()
	var ang = diff.angle()
	ang += Globals.rnd.randf_range(-.1, .1)
	diff = Vector2.RIGHT.rotated(ang)
	bullet.dir = diff
	main.add_child(bullet)
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


func died():
	alive = false
	self.visible = false
	main.unit_died(self)
