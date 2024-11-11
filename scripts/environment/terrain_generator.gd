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

## The number of times to try to add more doors to a room. Currently can fail.
@export var num_add_tries: int

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


func make_spaces(parent_node: Node) -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()

	# generate the height
	var height: int = rng.randi_range(min_dungeon_height,max_dungeon_height)
	# generate the half width
	var bottom_floor_width: int = rng.randi_range(2,3)
	# init the half widths to have the bottom 2 levels be the same
	var left_widths: Array[int] = [bottom_floor_width, bottom_floor_width]
	var right_widths: Array[int] = [bottom_floor_width, bottom_floor_width]
	# for each middle floor 
	for i in range(2, height - 1):
		# add a left width of either one less than before or the same but always above 0
		var previous_left_index_width: int = left_widths[i-1]
		var left_index_width_to_try: int = rng.randi_range(previous_left_index_width - 1, previous_left_index_width)
		left_widths.append(max(1, left_index_width_to_try))

		# add a right width of either one less than before or the same but always above 0
		var previous_right_index_width: int = right_widths[i-1]
		var right_index_width_to_try: int = rng.randi_range(previous_right_index_width - 1, previous_right_index_width)
		right_widths.append(max(1, right_index_width_to_try))

	# add the top levels which always have a width of 1
	left_widths.append(1)
	right_widths.append(1)

	# init the board
	var board = []
	# for each vertical level
	for current_vertical_level in range(height):
		var current_horizontal_level = []
		var current_left_width:int = left_widths[current_vertical_level]
		for i in range(bottom_floor_width - current_left_width):
			current_horizontal_level.append(Room.new())
		for i in range(current_left_width):
			var room: Room = Room.new()
			room.init_room_for_use(Vector2(current_horizontal_level.size() * room_x_length,current_vertical_level * room_y_length))
			current_horizontal_level.append(room)

		var room2: Room = Room.new()
		room2.init_room_for_use(Vector2(current_horizontal_level.size() * room_x_length,current_vertical_level * room_y_length))
		current_horizontal_level.append(room2)

		var current_right_width:int = right_widths[current_vertical_level]
		for i in range(current_right_width):
			var room: Room = Room.new()
			room.init_room_for_use(Vector2(current_horizontal_level.size() * room_x_length,current_vertical_level * room_y_length))
			current_horizontal_level.append(room)
		for i in range(bottom_floor_width - current_right_width):
			current_horizontal_level.append(Room.new())
		board.append(current_horizontal_level)
	
	check_next_room(height -2, bottom_floor_width, board, true)
	for i in range(num_add_tries):
		var x:int = rng.randi_range(0, bottom_floor_width * 2)
		var y:int = rng.randi_range(0, height-1)
		add_more_paths(y, x, board)

	for level in board:
		for room: Room in level:
			var scene: PackedScene = get_room(room)
			room.place_room(scene, parent_node)

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

func add_more_paths(x: int, y: int, board,) -> void:
	var current_room: Room = board[x][y]
	if current_room.useable:
		if y < board[x].size() - 1:
			var next_room: Room = board[x][y+1]
			if next_room.useable:
				current_room.remove_wall(CardinalDirection.EAST)
				next_room.remove_wall(CardinalDirection.WEST)
		if y > 0:
			var next_room: Room = board[x][y-1]
			if next_room.useable:
				current_room.remove_wall(CardinalDirection.WEST)
				next_room.remove_wall(CardinalDirection.EAST)
		if x < board.size() - 1:
			var next_room: Room = board[x+1][y]
			if next_room.useable:
				current_room.remove_wall(CardinalDirection.NORTH)
				next_room.remove_wall(CardinalDirection.SOUTH)
		if x > 0:
			var next_room: Room = board[x-1][y]
			if next_room.useable:
				current_room.remove_wall(CardinalDirection.SOUTH)
				next_room.remove_wall(CardinalDirection.NORTH)

func check_next_room(x: int, y: int, board, initial:bool = false) -> void:
	var directions_to_check: Array[int]
	# not seeded because this sucks
	if initial:
		directions_to_check = [CardinalDirection.NORTH, CardinalDirection.EAST, CardinalDirection.WEST]
		directions_to_check.shuffle()
		directions_to_check.remove_at(0)
		directions_to_check.remove_at(0)
	else:
		directions_to_check = [CardinalDirection.NORTH, CardinalDirection.EAST, CardinalDirection.SOUTH, CardinalDirection.WEST]
		directions_to_check.shuffle()

	var current_room: Room = board[x][y]
	if initial:
		current_room.useable = false
	for direction_to_check in directions_to_check:
		if direction_to_check == CardinalDirection.EAST and y < board[x].size() - 1:
			var next_room: Room = board[x][y+1]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.WEST)
				check_next_room(x, y+1, board)
		elif direction_to_check == CardinalDirection.WEST and y > 0:
			var next_room: Room = board[x][y-1]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.EAST)
				check_next_room(x, y-1, board)
		elif direction_to_check == CardinalDirection.NORTH and x < board.size() - 1:
			var next_room: Room = board[x+1][y]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.SOUTH)
				check_next_room(x+1, y, board)
		elif direction_to_check == CardinalDirection.SOUTH and x > 0:
			var next_room: Room = board[x-1][y]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.NORTH)
				check_next_room(x-1, y, board)
