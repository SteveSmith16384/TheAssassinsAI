extends Node2D

const SPEED = 2

var route = []

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if route.empty():
		var dest = Vector2(300, 300)
		route = Globals.get_route(self.position, dest)
	else:
		var dest:Vector2 = route[0]
		if dest.distance_to(self.position) < 3:
			route.remove(0)
		else:
			var diff = (dest - self.position).normalized() * SPEED
			self.position += diff
	pass
