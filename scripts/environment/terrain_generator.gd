class_name TerrainGenerator extends Resource
## A class that generates the dungeon rooms for a play through.

## The max number of rooms the dungeon can have vertically.
@export var max_dungeon_height: int = 6

## The min number of rooms the dungeon can have vertically.
@export var min_dungeon_height: int = 4

## The max number of rooms in half the dungeon's width.
@export var max_half_dungeon_width: int = 2

## The min number of rooms in half the dungeon's width.
@export var min_half_dungeon_width: int = 0

## The minimum number of rooms to add extra doors to after dungeon generation.
@export var min_num_rooms_to_add_extra_doors: int = 0

## The maximum number of rooms to add extra doors to after dungeon generation.
@export var max_num_rooms_to_add_extra_doors: int = 3

## The prefab with a door to the north.
@export var door_north: PackedScene
## The prefab with a door to the north and south.
@export var door_north_south: PackedScene
## The prefab with a door to the north and east.
@export var door_north_east: PackedScene
## The prefab with a door to the north and west.
@export var door_north_west: PackedScene
## The prefab with a door to the north and south and east.
@export var door_north_south_east: PackedScene
## The prefab with a door to the north and south and west.
@export var door_north_south_west: PackedScene
## The prefab with a door to the north and east and west.
@export var door_north_east_west: PackedScene
## The prefab with a door to the north and south and east and west.
@export var door_north_south_east_west: PackedScene
## The prefab with a door to the south.
@export var door_south: PackedScene
## The prefab with a door to the south and east.
@export var door_south_east: PackedScene
## The prefab with a door to the south and west.
@export var door_south_west: PackedScene
## The prefab with a door to the south and east and west.
@export var door_south_east_west: PackedScene
## The prefab with a door to the east.
@export var door_east: PackedScene
## The prefab with a door to the east and west.
@export var door_east_west: PackedScene
## The prefab with a door to the west.
@export var door_west: PackedScene

## The amount of pixels in the x direction of a room prefab.
@export var room_x_length: int
## The amount of pixels in the y direction of a room prefab.
@export var room_y_length: int

## The possible door locations for the boss room.
const possible_boss_room_directions: Array[int] = [CardinalDirection.NORTH, CardinalDirection.EAST, CardinalDirection.WEST]

## Generates the dungeon and palces the rooms under the given node.
func generate_dungeon(parent_node: Node) -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()

	# generate the height
	var height: int = rng.randi_range(min_dungeon_height,max_dungeon_height)
	# generate the half width
	var bottom_floor_width: int = rng.randi_range(2,3)
	# init the half widths to have the bottom 2 levels be the same
	var left_widths: Array[int] = create_side_width(rng, height, bottom_floor_width)
	var right_widths: Array[int] = create_side_width(rng, height, bottom_floor_width)

	var board = create_rooms(height, bottom_floor_width, left_widths, right_widths)

	remove_walls_from_room(height -2, bottom_floor_width, board, true)
	randomly_remove_walls_from_dungeon(board, rng)
	instantiate_rooms(board, parent_node)

## Function that recursively removes walls from every room until all rooms have a path to them.
func remove_walls_from_room(x: int, y: int, board, initial:bool = false) -> void:
	var directions_to_check: Array[int]
	var current_room: Room = board[x][y]

	# If its the initial room to check, the boss room, randomly choose a possible direction to enter the room.
	if initial:
		directions_to_check = possible_boss_room_directions.duplicate(true)
		directions_to_check.shuffle()
		while directions_to_check.size() > 1:
			directions_to_check.remove_at(0)
		# Set the current room to not useable so we do not put more than one door in it.
		current_room.useable = false
	## Otherwise randomize which direction to check first for this room
	else:
		directions_to_check = [CardinalDirection.NORTH, CardinalDirection.EAST, CardinalDirection.SOUTH, CardinalDirection.WEST]
		directions_to_check.shuffle()
	
	for direction_to_check in directions_to_check:
		# If we are checking the eastern room and we are not on the eastern edge of the map.
		# Then remove the next eastern wall in this room and the western room of the next room and try to remove walls from the next room.
		if direction_to_check == CardinalDirection.EAST and y < board[x].size() - 1:
			var next_room: Room = board[x][y+1]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.WEST)
				remove_walls_from_room(x, y+1, board)
		# If we are checking the western room and we are not on the western edge of the map.
		# Then remove the next western wall in this room and the eastern room of the next room and try to remove walls from the next room.
		elif direction_to_check == CardinalDirection.WEST and y > 0:
			var next_room: Room = board[x][y-1]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.EAST)
				remove_walls_from_room(x, y-1, board)
		# If we are checking the northern room and we are not on the northern edge of the map.
		# Then remove the next southern wall in this room and the northern room of the next room and try to remove walls from the next room.
		elif direction_to_check == CardinalDirection.NORTH and x < board.size() - 1:
			var next_room: Room = board[x+1][y]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.SOUTH)
				remove_walls_from_room(x+1, y, board)
		# If we are checking the southern room and we are not on the southern edge of the map.
		# Then remove the next northern wall in this room and the southern room of the next room and try to remove walls from the next room.
		elif direction_to_check == CardinalDirection.SOUTH and x > 0:
			var next_room: Room = board[x-1][y]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.NORTH)
				remove_walls_from_room(x-1, y, board)

## Randomly removes walls from rooms in the dungeon.
func randomly_remove_walls_from_dungeon(board, rng: RandomNumberGenerator) -> void:

	var i = rng.randi_range(min_num_rooms_to_add_extra_doors, max_num_rooms_to_add_extra_doors)
	var max_tries = 20

	while i > 0 and max_tries > 0:
		var x:int = rng.randi_range(0, board[0].size() - 1)
		var y:int = rng.randi_range(0, board.size() - 1)
		if remove_all_possible_walls_from_room(y, x, board):
			i -= 1

		# update failsafe
		max_tries -=1
		if max_tries <= 0:
			print("Error removing walls from dungeon. Ran out of tries.")

## Instantiates the rooms in the board under the given node.
func instantiate_rooms(board, parent_node: Node) -> void:
	for level in board:
		for room: Room in level:
			var scene: PackedScene = get_room(room)
			room.place_room(scene, parent_node)

## Randomly decides the width of a single side of the dungeon.
func create_side_width(rng: RandomNumberGenerator, height: int, bottom_floor_width: int) -> Array[int]:

	# init the half widths to have the bottom 2 levels be the same
	var widths: Array[int] = [bottom_floor_width, bottom_floor_width]

	# for each middle floor 
	for i in range(2, height - 1):
		# add a left width of either one less than before or the same but always above 0
		var previous_left_index_width: int = widths[i-1]
		var left_index_width_to_try: int = rng.randi_range(previous_left_index_width - 1, previous_left_index_width)
		widths.append(max(1, left_index_width_to_try))

	# add the top levels which always have a width of 1
	widths.append(1)
	return widths

## Initializes the rooms for use in the dungeon path creation algorithm. 
func create_rooms(height: int, bottom_floor_width: int, left_widths: Array[int], right_widths: Array[int]):
	# init the board
	var board = []

	# for each vertical level
	for current_vertical_level in range(height):
		var current_horizontal_level = []
		var current_left_width:int = left_widths[current_vertical_level]

		# create unuseable rooms where they are not marked on the left.
		for i in range(bottom_floor_width - current_left_width):
			current_horizontal_level.append(Room.new())
		# create useable rooms where they are marked on the left.
		for i in range(current_left_width):
			var room: Room = Room.new()
			room.init_room_for_use(Vector2(current_horizontal_level.size() * room_x_length, current_vertical_level * room_y_length))
			current_horizontal_level.append(room)

		# create the useable room in the middle.
		var middle_room: Room = Room.new()
		middle_room.init_room_for_use(Vector2(current_horizontal_level.size() * room_x_length, current_vertical_level * room_y_length))
		current_horizontal_level.append(middle_room)

		# create useable rooms where they are marked on the right.
		var current_right_width:int = right_widths[current_vertical_level]
		for i in range(current_right_width):
			var room: Room = Room.new()
			room.init_room_for_use(Vector2(current_horizontal_level.size() * room_x_length, current_vertical_level * room_y_length))
			current_horizontal_level.append(room)
		# create unuseable rooms where they are not marked on the right.
		for i in range(bottom_floor_width - current_right_width):
			current_horizontal_level.append(Room.new())
		board.append(current_horizontal_level)

	return board

## Gets the room prefab based on what walls a room has.
func get_room(room: Room) -> PackedScene:
	if room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.EAST):
		return door_west
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.WEST):
		return door_east
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.EAST) and room.wall_location.has(CardinalDirection.WEST):
		return door_south
	elif room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.EAST) and room.wall_location.has(CardinalDirection.WEST):
		return door_north
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.SOUTH):
		return door_east_west
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.EAST):
		return door_south_west
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.WEST):
		return door_south_east
	elif room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.EAST):
		return door_north_west
	elif room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.WEST):
		return door_north_east
	elif room.wall_location.has(CardinalDirection.EAST) and room.wall_location.has(CardinalDirection.WEST):
		return door_north_south
	elif room.wall_location.has(CardinalDirection.NORTH):
		return door_south_east_west
	elif room.wall_location.has(CardinalDirection.SOUTH):
		return door_north_east_west
	elif room.wall_location.has(CardinalDirection.EAST):
		return door_north_south_west
	elif room.wall_location.has(CardinalDirection.WEST):
		return door_north_south_east
	else:
		return door_north_south_east_west

## Tries to remove all walls from the given board location.
func remove_all_possible_walls_from_room(x: int, y: int, board) -> bool:
	var removed_wall: bool = false
	var current_room: Room = board[x][y]
	# If the room is allowed to lose walls
	if current_room.useable:
		# Remove the eastern wall if it exists 
		if y < board[x].size() - 1:
			var next_room: Room = board[x][y+1]
			if next_room.useable and current_room.wall_location.has(CardinalDirection.EAST):
				current_room.remove_wall(CardinalDirection.EAST)
				next_room.remove_wall(CardinalDirection.WEST)
				removed_wall = true
		# Remove the western wall if it exists 
		if y > 0:
			var next_room: Room = board[x][y-1]
			if next_room.useable and current_room.wall_location.has(CardinalDirection.WEST):
				current_room.remove_wall(CardinalDirection.WEST)
				next_room.remove_wall(CardinalDirection.EAST)
				removed_wall = true
		# Remove the northern wall if it exists 
		if x < board.size() - 1:
			var next_room: Room = board[x+1][y]
			if next_room.useable and current_room.wall_location.has(CardinalDirection.NORTH):
				current_room.remove_wall(CardinalDirection.NORTH)
				next_room.remove_wall(CardinalDirection.SOUTH)
				removed_wall = true
		# Remove the southern wall if it exists 
		if x > 0:
			var next_room: Room = board[x-1][y]
			if next_room.useable and current_room.wall_location.has(CardinalDirection.SOUTH):
				current_room.remove_wall(CardinalDirection.SOUTH)
				next_room.remove_wall(CardinalDirection.NORTH)
				removed_wall = true
	return removed_wall
