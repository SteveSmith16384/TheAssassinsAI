extends Node2D

const unit_class = preload("res://Unit.tscn")

func _ready():
	var unit = unit_class.instance()
	unit.position = Vector2(10, 10)
	self.add_child(unit)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
