class_name TerrainGenerator extends Resource

@export var max_layers: int = 6
@export var min_layers: int = 4

@export var max_width: int = 2
@export var min_width: int = 0

func make_spaces() -> void:
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
			room.init_room_for_use()
			level.append(room)

		var room2: Room = Room.new()
		room2.init_room_for_use()
		level.append(room2)

		var current_right_width:int = right_widths[current_level]
		for i in range(current_right_width):
			var room: Room = Room.new()
			room.init_room_for_use()
			level.append(room)
		for i in range(bottom_floor_width - current_right_width):
			level.append(Room.new())
		board.append(level)
	
	check_next_room(bottom_floor_width, height - 2, board)
	print("-----")
	board.reverse()
	for level in board:
		var top: String=""
		var mid: String=""
		var bot: String=""
		for room in level:
			var vals: Array[String] = (room as Room).get_debug_string()
			top+=vals[0]
			mid+=vals[1]
			bot+=vals[2]
		print(top)
		print(mid)
		print(bot)

func check_next_room(x: int, y: int, board) -> void:
	var directions_to_check: Array[int] = [CardinalDirection.NORTH, CardinalDirection.EAST, CardinalDirection.SOUTH, CardinalDirection.WEST]
	# not seeded because this sucks
	directions_to_check.shuffle()
	var current_room: Room = board[x][y]
	for direction_to_check in directions_to_check:
		# up
		if direction_to_check == CardinalDirection.NORTH and y < board[x].size() - 1:
			var next_room: Room = board[x][y+1]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.SOUTH)
				check_next_room(x, y+1, board)
		elif direction_to_check == CardinalDirection.SOUTH and y > 0:
			var next_room: Room = board[x][y-1]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.NORTH)
				check_next_room(x, y-1, board)
		elif direction_to_check == CardinalDirection.EAST and x < board.size() - 1:
			var next_room: Room = board[x+1][y]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.WEST)
				check_next_room(x+1, y, board)
		elif direction_to_check == CardinalDirection.WEST and x > 0:
			var next_room: Room = board[x-1][y]
			if next_room.useable and !next_room.visited:
				current_room.remove_wall(direction_to_check)
				next_room.remove_wall(CardinalDirection.EAST)
				check_next_room(x-1, y, board)
