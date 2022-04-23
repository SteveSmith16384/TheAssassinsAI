extends Node2D

func _ready():
	var astar : AStar2D = AStar2D.new()

	var csn_class = preload("res://Wall.tscn")
	var CITY_SIZE = Globals.MAP_SIZE

	var bmap = {} # Vector2, bool=floor
	var nodes = {} # Vector2, id 
#	var id:int = 0

	# Add walls
	for y in CITY_SIZE:
		for x in CITY_SIZE:
			var xpos = x * Globals.SQ_SIZE
			var ypos = y * Globals.SQ_SIZE
			var vec = Vector2(xpos, ypos)
			if Globals.rnd.randi_range(0, 4) == 0 or x == 0 or y == 0 or x == CITY_SIZE-1 or y == CITY_SIZE-1:
				bmap[vec] = false
				# Create wall
				var wall = csn_class.instance()
				wall.position.x = xpos
				wall.position.y = ypos
				self.add_child(wall)
			else:
				var id = astar.get_available_point_id()
				bmap[vec] = true
				astar.add_point(id, vec)
				nodes[vec] = id
	#			id += 1
				
	# Connect nodes
	for y in CITY_SIZE:
		for x in CITY_SIZE:
			if x == 0 or y == 0 or x == CITY_SIZE-2 or y == CITY_SIZE-2:
				continue
			var xpos = x * Globals.SQ_SIZE
			var ypos = y * Globals.SQ_SIZE
			var vec = Vector2(xpos, ypos)
			if bmap[vec] == true: # floor
				var vec_l = Vector2(xpos-Globals.SQ_SIZE, ypos)
				if bmap[vec_l]:
					astar.connect_points(nodes[vec], nodes[vec_l])
				var vec_r = Vector2(xpos+Globals.SQ_SIZE, ypos)
				if bmap[vec_r]:
					astar.connect_points(nodes[vec], nodes[vec_r])
				var vec_u = Vector2(xpos, ypos-Globals.SQ_SIZE)
				if bmap[vec_u]:
					astar.connect_points(nodes[vec], nodes[vec_u])
				var vec_d = Vector2(xpos, ypos+Globals.SQ_SIZE)
				if bmap[vec_d]:
					astar.connect_points(nodes[vec], nodes[vec_d])
					
	Globals.astar = astar
	pass


