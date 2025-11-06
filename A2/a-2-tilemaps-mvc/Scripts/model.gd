class_name Model
extends RefCounted

# Signals for Observer pattern
signal board_updated(x: int, y: int, player: int)
signal turn_changed(current_player: int)
signal game_won(winner: int)
signal game_draw()
signal game_reset()

# Constants
enum Player { EMPTY = 0, X = 1, O = 2 }

# Game state
var board: Array[Array] = []
var current_player: int = Player.X
var game_over: bool = false

func _init() -> void:
	initialize_board()

func initialize_board() -> void:
	board = []
	for i in range(3):
		var row: Array[int] = []
		for j in range(3):
			row.append(Player.EMPTY)
		board.append(row)
	current_player = Player.X
	game_over = false

func make_move(x: int, y: int) -> bool:
	# Check if game is over
	if game_over:
		return false
	
	# Check if position is valid
	if x < 0 or x >= 3 or y < 0 or y >= 3:
		return false
	
	# Check if tile is already claimed
	if board[y][x] != Player.EMPTY:
		return false
	
	# Make the move
	board[y][x] = current_player
	board_updated.emit(x, y, current_player)
	
	# Check for win or draw
	if check_win(current_player):
		game_over = true
		game_won.emit(current_player)
		return true
	
	if check_draw():
		game_over = true
		game_draw.emit()
		return true
	
	# Switch turns
	switch_turn()
	return true

func switch_turn() -> void:
	current_player = Player.O if current_player == Player.X else Player.X
	turn_changed.emit(current_player)

func check_win(player: int) -> bool:
	# Check rows
	for y in range(3):
		if board[y][0] == player and board[y][1] == player and board[y][2] == player:
			return true
	
	# Check columns
	for x in range(3):
		if board[0][x] == player and board[1][x] == player and board[2][x] == player:
			return true
	
	# Check diagonals
	if board[0][0] == player and board[1][1] == player and board[2][2] == player:
		return true
	if board[0][2] == player and board[1][1] == player and board[2][0] == player:
		return true
	
	return false

func check_draw() -> bool:
	##
	##Check if the game is a draw (board full with no winner)
	##
	for y in range(3):
		for x in range(3):
			if board[y][x] == Player.EMPTY:
				return false
	return true

func reset_game() -> void:
	initialize_board()
	game_reset.emit()
	turn_changed.emit(current_player)

func get_cell(x: int, y: int) -> int:
	if x < 0 or x >= 3 or y < 0 or y >= 3:
		return Player.EMPTY
	return board[y][x]
