extends Position3D

export var vehicle: bool
var links = []

func highlight(i:int):
	#$DebuggingSphere.highlight(i)
	pass
	
	
func get_next_navpoint(except): #-> NavPoint
	var m = links.size()
	if m < 1:
		#push_error("Not enough children!")
		return null
	elif m == 1:
		return links[0]
	elif m > 4:
		print("here")
	while true:
		var idx = Globals.rnd.randi_range(0, m-1)
		if links[idx] != except:
			return links[idx]
	pass	


func _on_Area_Connect_area_entered(area):
	if vehicle == false:
		return
		
	if area.get_parent() == self:
		return
		
	var p = area.get_parent();
	if p.is_in_group("nav_point") == false:
		return
	
	if p.vehicle != self.vehicle:
		return
		
	#var dist2 = area.global_transform.origin.distance_to(self.global_transform.origin)

	# Check it can be seen from this node
	$RayCast.global_transform.origin = self.global_transform.origin
	$RayCast.cast_to = p.global_transform.origin - self.global_transform.origin
	$RayCast.force_raycast_update()
	var coll = $RayCast.get_collider()
	#var cp = $RayCast.get_collision_point()
	if coll != null:
		return

	links.push_back(p)
	var m = links.size()
	if m > 4:
		print("here")

	pass


func _on_Area_Connect_area_exited(area):
	if area.get_parent() == self:
		return
		
	var p = area.get_parent();
	if p.is_in_group("nav_point"):
		links.erase(p)
	pass
