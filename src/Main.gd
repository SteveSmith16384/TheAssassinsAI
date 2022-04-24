extends Node2D

const unit_class = preload("res://Unit.tscn")

var units = []

func _ready():
	var unit = unit_class.instance()
	unit.position = Vector2(10, 10)
	unit.side = 1
	self.add_child(unit)
	units.push_back(unit)

	unit = unit_class.instance()
	unit.position = Vector2(360, 360)
	unit.side = 2
	self.add_child(unit)
	units.push_back(unit)

	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

