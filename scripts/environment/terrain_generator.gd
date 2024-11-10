class_name TerrainGenerator extends Resource

@export var max_layers: int = 6
@export var min_layers: int = 4

@export var max_width: int = 2
@export var min_width: int = 0

@export var north: PackedScene
@export var north_south: PackedScene
@export var north_east: PackedScene
@export var north_west: PackedScene
@export var north_south_east: PackedScene
@export var north_south_west: PackedScene
@export var north_east_west: PackedScene
@export var north_south_east_west: PackedScene

@export var south: PackedScene
@export var south_east: PackedScene
@export var south_west: PackedScene
@export var south_east_west: PackedScene

@export var east: PackedScene
@export var east_west: PackedScene

@export var west: PackedScene

@export var room_x_length: int
@export var room_y_length: int

func make_spaces(parent_node: Node) -> void:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()

	var height: int = rng.randi_range(min_layers,max_layers)
	var bottom_floor_width: int = rng.randi_range(2,3)

	var left_widths: Array[int] = [bottom_floor_width, bottom_floor_width]
	var right_widths: Array[int] = [bottom_floor_width, bottom_floor_width]
	
	for i in range(2, height - 1):
		var previous_left_index_width: int = left_widths[i-1]
		var left_index_width_to_try: int = rng.randi_range(previous_left_index_width - 1, previous_left_index_width)
		left_widths.append(max(1, left_index_width_to_try))

		var previous_right_index_width: int = right_widths[i-1]
		var right_index_width_to_try: int = rng.randi_range(previous_right_index_width - 1, previous_right_index_width)
		right_widths.append(max(1, right_index_width_to_try))

	left_widths.append(1)
	right_widths.append(1)

	print("here is a board yay")
	
	var board = []
	for current_level in range(height):
		var level = []
		var current_left_width:int = left_widths[current_level]
		for i in range(bottom_floor_width - current_left_width):
			level.append(Room.new())
		for i in range(current_left_width):
			var room: Room = Room.new()
			room.init_room_for_use(Vector2(level.size() * room_x_length,current_level * room_y_length))
			level.append(room)

		var room2: Room = Room.new()
		room2.init_room_for_use(Vector2(level.size() * room_x_length,current_level * room_y_length))
		level.append(room2)

		var current_right_width:int = right_widths[current_level]
		for i in range(current_right_width):
			var room: Room = Room.new()
			room.init_room_for_use(Vector2(level.size() * room_x_length,current_level * room_y_length))
			level.append(room)
		for i in range(bottom_floor_width - current_right_width):
			level.append(Room.new())
		board.append(level)
	
	check_next_room(bottom_floor_width, height - 2, board)
	# board.reverse()
	for level in board:
		var top_string: String=""
		var mid_string: String=""
		var bot_string: String=""
		for room: Room in level:
			var scene: PackedScene = get_room(room)
			room.place_room(scene, parent_node)
			var vals: Array[String] = (room as Room).get_debug_string()
			top_string+=vals[0]
			mid_string+=vals[1]
			bot_string+=vals[2]
		print(top_string)
		print(mid_string)
		print(bot_string)

func get_room(room: Room) -> PackedScene:
	if room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.EAST):
		return west
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.WEST):
		return east
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.EAST) and room.wall_location.has(CardinalDirection.WEST):
		return south
	elif room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.EAST) and room.wall_location.has(CardinalDirection.WEST):
		return north
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.SOUTH):
		return east_west
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.EAST):
		return south_west
	elif room.wall_location.has(CardinalDirection.NORTH) and room.wall_location.has(CardinalDirection.WEST):
		return south_east
	elif room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.EAST):
		return north_west
	elif room.wall_location.has(CardinalDirection.SOUTH) and room.wall_location.has(CardinalDirection.WEST):
		return north_east
	elif room.wall_location.has(CardinalDirection.EAST) and room.wall_location.has(CardinalDirection.WEST):
		return north_south
	elif room.wall_location.has(CardinalDirection.NORTH):
		return south_east_west
	elif room.wall_location.has(CardinalDirection.SOUTH):
		return north_east_west
	elif room.wall_location.has(CardinalDirection.EAST):
		return north_south_west
	elif room.wall_location.has(CardinalDirection.WEST):
		return north_south_east
	else:
		return north_south_east_west

func check_next_room(x: int, y: int, board) -> void:
	var directions_to_check: Array[int] = [CardinalDirection.NORTH, CardinalDirection.EAST, CardinalDirection.SOUTH, CardinalDirection.WEST]
	# not seeded because this sucks
	directions_to_check.shuffle()
	var current_room: Room = board[x][y]
	for direction_to_check in directions_to_check:
		# up
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
