class_name View
extends TileMapLayer

## View - Visual Display
## This class handles the visual representation of the game board using a TileMap.
## It displays X and O symbols on the board, captures mouse clicks on tiles,
## and updates the display when the game state changes.

# Constants for tile IDs (based on spritesheet)
# Column 0: O tile (circle)
# Column 1: X tile (red X)
# Column 2: Empty tile (white background)
const TILE_EMPTY = Vector2i(2, 0)
const TILE_X = Vector2i(1, 0)
const TILE_O = Vector2i(0, 0)

# Reference to model for initial board setup
var model: Model

func _ready() -> void:
	initialize_visual_board()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			var local_pos = to_local(event.position)
			var tile_coords = local_to_map(local_pos)
			
			if tile_coords.x >= 0 and tile_coords.x < 3 and tile_coords.y >= 0 and tile_coords.y < 3:
				if model:
					model.make_move(tile_coords.x, tile_coords.y)




#Set up the game board
func initialize_visual_board() -> void:
	clear()
	for y in range(3):
		for x in range(3):
			set_cell(Vector2i(x, y), 0, TILE_EMPTY)

func on_board_updated(x: int, y: int, player: int) -> void:
	var tile_coords: Vector2i
	match player:
		Model.Player.X:
			tile_coords = TILE_X
		Model.Player.O:
			tile_coords = TILE_O
		_:
			tile_coords = TILE_EMPTY
	
	set_cell(Vector2i(x, y), 0, tile_coords)

func on_game_reset() -> void:
	initialize_visual_board()

func world_to_board(screen_pos: Vector2) -> Vector2i:
	var local_pos = to_local(screen_pos)
	var tile_coords = local_to_map(local_pos)
	return tile_coords
