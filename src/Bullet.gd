extends Node2D

const SPEED = 100

var shooter
var dir: Vector2

func _process(delta):
	self.position += dir * SPEED * delta
	pass


func _on_Area_body_entered(body):
	self.queue_free()
	pass


func _on_Area_area_entered(area):
	if area.is_in_group("physical") == false:
		return
	var parent = area.get_parent()
	if parent.is_in_group("units") == false:
		return
	if parent.side == shooter.side:
		return
	parent.died()
	self.queue_free()
	pass
