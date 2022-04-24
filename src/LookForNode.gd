extends Node2D

onready var main = get_tree().get_root().get_node("Main")


func _on_Timer_CheckSeen_timeout():
	for unit in main.units:
		if unit.side != 1:
			continue
		if main.is_in_line_of_sight(self, unit): # todo - only check if in range
			self.queue_free()
			return
	pass
