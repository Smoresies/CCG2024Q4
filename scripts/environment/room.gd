class_name Room extends RefCounted
## A class to help generate rooms.

## The walls that are in this room.
var wall_location: Dictionary = {}

## If the dungeon making algorithm has looks at this room before.
var visited: bool = false

## If this room is a valid room to go to. An invalid room is just a placeholder in an array.
var useable: bool = false

## The place to instantiate the room.
var spawn_position: Vector2

## Initializes a room to be used with a given spawn position.
func init_room_for_use(position: Vector2) -> void:
	spawn_position = position
	wall_location.get_or_add(CardinalDirection.NORTH)
	wall_location.get_or_add(CardinalDirection.SOUTH)
	wall_location.get_or_add(CardinalDirection.EAST)
	wall_location.get_or_add(CardinalDirection.WEST)
	useable = true

## Removes the given wall and sets it as visited.
func remove_wall(wall_to_remove: int) -> void:
	visited = true
	wall_location.erase(wall_to_remove)

## Places the given room at its spawn location and attaches it to the given node.
func place_room(room_to_place: PackedScene, node: Node2D) -> void:
	# Only place the room if it has been used
	if visited:
		var room: Node2D = room_to_place.instantiate()
		room.global_position = spawn_position
		node.add_child(room)
