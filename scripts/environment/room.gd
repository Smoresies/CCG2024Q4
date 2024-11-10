class_name Room extends RefCounted

var wall_location: Dictionary = {}

var visited: bool = false

var useable: bool = false

func init_room_for_use() -> void:
	wall_location.get_or_add(CardinalDirection.NORTH)
	wall_location.get_or_add(CardinalDirection.SOUTH)
	wall_location.get_or_add(CardinalDirection.EAST)
	wall_location.get_or_add(CardinalDirection.WEST)
	useable = true

func remove_wall(wall_to_remove: int) -> void:
	if wall_to_remove >= 0:
		visited = true
		wall_location.erase(wall_to_remove)

func get_debug_string() -> Array[String]:
	var walls: Array[String] = []
	if useable:
		if wall_location.has(CardinalDirection.NORTH):
			walls.append("---")
		else:
			walls.append("   ")

		if wall_location.has(CardinalDirection.EAST) and wall_location.has(CardinalDirection.WEST):
			walls.append("| |")
		elif wall_location.has(CardinalDirection.WEST):
			walls.append("|  ")
		elif wall_location.has(CardinalDirection.EAST):
			walls.append("  |")
		else:
			walls.append("   ")

		if wall_location.has(CardinalDirection.SOUTH):
			walls.append("---")
		else:
			walls.append("   ")
	else:
		walls.append("XXX")
		walls.append("XXX")
		walls.append("XXX")
	return walls
