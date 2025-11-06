## Tic-Tac-Toe Model Unit Tests
## -----------------------------
## This test suite uses GUT (Godot Unit Test framework, work with Godot version 4.5) to validate the Model class.
## It checks game initialization, move validation, turn switching, win/draw detection,
## game reset functionality, and observer pattern signal emissions.

extends GutTest

var ModelClass = preload("res://Scripts/model.gd")
var model = null

## Test that the board starts with all empty cells.
func test_initial_board_is_empty():
	model = ModelClass.new()
	for y in range(3):
		for x in range(3):
			assert_eq(model.get_cell(x, y), ModelClass.Player.EMPTY,
				"Cell (%d, %d) should be empty at start" % [x, y])

## Test that X player starts first.
func test_initial_player_is_x():
	model = ModelClass.new()
	assert_eq(model.current_player, ModelClass.Player.X, "X should be the starting player")

## Test that game_over flag is false at start.
func test_game_not_over_at_start():
	model = ModelClass.new()
	assert_false(model.game_over, "Game should not be over at start")

## Test that a move on an empty cell succeeds.
func test_valid_move_on_empty_cell():
	model = ModelClass.new()
	var result = model.make_move(0, 0)
	assert_true(result, "Move on empty cell should succeed")
	assert_eq(model.get_cell(0, 0), ModelClass.Player.X, "Cell should contain X after move")

## Test that a move on a claimed cell fails.
func test_invalid_move_on_claimed_cell():
	model = ModelClass.new()
	model.make_move(0, 0)
	var result = model.make_move(0, 0)
	assert_false(result, "Move on claimed cell should fail")
	assert_eq(model.get_cell(0, 0), ModelClass.Player.X, "Cell should still contain X")

## Test that moves outside board (negative coordinates) fail.
func test_invalid_move_out_of_bounds_negative():
	model = ModelClass.new()
	var result = model.make_move(-1, 0)
	assert_false(result, "Move at x=-1 should fail")
	result = model.make_move(0, -1)
	assert_false(result, "Move at y=-1 should fail")

## Test that moves outside board (too large coordinates) fail.
func test_invalid_move_out_of_bounds_positive():
	model = ModelClass.new()
	var result = model.make_move(3, 0)
	assert_false(result, "Move at x=3 should fail")
	result = model.make_move(0, 3)
	assert_false(result, "Move at y=3 should fail")

## Test that moves fail after game is over.
func test_moves_blocked_after_game_over():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(0, 1)
	model.make_move(1, 1)
	model.make_move(0, 2)
	var result = model.make_move(2, 2)
	assert_false(result, "Moves should be blocked after game over")

## Test that player turn switches after a valid move.
func test_turn_switches_after_valid_move():
	model = ModelClass.new()
	assert_eq(model.current_player, ModelClass.Player.X, "Should start with X")
	model.make_move(0, 0)
	assert_eq(model.current_player, ModelClass.Player.O, "Should switch to O")
	model.make_move(1, 1)
	assert_eq(model.current_player, ModelClass.Player.X, "Should switch back to X")

## Test that turn doesn't switch on invalid move.
func test_turn_does_not_switch_on_invalid_move():
	model = ModelClass.new()
	model.make_move(0, 0)
	assert_eq(model.current_player, ModelClass.Player.O)
	model.make_move(0, 0)
	assert_eq(model.current_player, ModelClass.Player.O, "Turn should remain O after invalid move")

## Test win detection for top row (row 0).
func test_win_detection_row_0():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(0, 1)
	model.make_move(1, 0)
	model.make_move(1, 1)
	model.make_move(2, 0)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test win detection for middle row (row 1).
func test_win_detection_row_1():
	model = ModelClass.new()
	model.make_move(0, 1)
	model.make_move(0, 0)
	model.make_move(1, 1)
	model.make_move(1, 0)
	model.make_move(2, 1)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test win detection for bottom row (row 2).
func test_win_detection_row_2():
	model = ModelClass.new()
	model.make_move(0, 2)
	model.make_move(0, 0)
	model.make_move(1, 2)
	model.make_move(1, 0)
	model.make_move(2, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test win detection for left column (column 0).
func test_win_detection_column_0():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(0, 1)
	model.make_move(1, 1)
	model.make_move(0, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test win detection for middle column (column 1).
func test_win_detection_column_1():
	model = ModelClass.new()
	model.make_move(1, 0)
	model.make_move(0, 0)
	model.make_move(1, 1)
	model.make_move(0, 1)
	model.make_move(1, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test win detection for right column (column 2).
func test_win_detection_column_2():
	model = ModelClass.new()
	model.make_move(2, 0)
	model.make_move(0, 0)
	model.make_move(2, 1)
	model.make_move(0, 1)
	model.make_move(2, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test win detection for main diagonal (top-left to bottom-right).
func test_win_detection_diagonal_main():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(1, 1)
	model.make_move(2, 0)
	model.make_move(2, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test win detection for anti-diagonal (top-right to bottom-left).
func test_win_detection_diagonal_anti():
	model = ModelClass.new()
	model.make_move(2, 0)
	model.make_move(0, 0)
	model.make_move(1, 1)
	model.make_move(0, 1)
	model.make_move(0, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.X), "X should have won")

## Test that O player can also win.
func test_o_player_can_win():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(0, 1)
	model.make_move(1, 1)
	model.make_move(2, 2)
	model.make_move(1, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_win(ModelClass.Player.O), "O should have won")

## Test draw detection when board is full with no winner.
func test_draw_detection_full_board():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(2, 0)
	model.make_move(1, 1)
	model.make_move(0, 1)
	model.make_move(2, 1)
	model.make_move(1, 2)
	model.make_move(0, 2)
	model.make_move(2, 2)
	assert_true(model.game_over, "Game should be over")
	assert_true(model.check_draw(), "Should be a draw")
	assert_false(model.check_win(ModelClass.Player.X), "X should not have won")
	assert_false(model.check_win(ModelClass.Player.O), "O should not have won")

## Test that draw is not detected with empty cells remaining.
func test_not_draw_with_empty_cells():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 1)
	assert_false(model.check_draw(), "Should not be a draw with empty cells remaining")

## Test that reset clears the board to empty state.
func test_reset_clears_board():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 1)
	model.make_move(2, 2)
	model.reset_game()
	for y in range(3):
		for x in range(3):
			assert_eq(model.get_cell(x, y), ModelClass.Player.EMPTY,
				"Cell (%d, %d) should be empty after reset" % [x, y])

## Test that reset sets current player back to X.
func test_reset_sets_player_to_x():
	model = ModelClass.new()
	model.make_move(0, 0)
	assert_eq(model.current_player, ModelClass.Player.O)
	model.reset_game()
	assert_eq(model.current_player, ModelClass.Player.X, "Current player should be X after reset")

## Test that reset clears the game_over flag.
func test_reset_clears_game_over():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(0, 1)
	model.make_move(1, 1)
	model.make_move(0, 2)
	assert_true(model.game_over)
	model.reset_game()
	assert_false(model.game_over, "game_over should be false after reset")

## Test that moves can be made after reset.
func test_can_make_moves_after_reset():
	model = ModelClass.new()
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(0, 1)
	model.make_move(1, 1)
	model.make_move(0, 2)
	model.reset_game()
	var result = model.make_move(1, 1)
	assert_true(result, "Should be able to make moves after reset")
	assert_eq(model.get_cell(1, 1), ModelClass.Player.X, "Cell should contain X after reset and move")

## Test that board_updated signal is emitted on valid move.
func test_board_updated_signal_emitted():
	model = ModelClass.new()
	watch_signals(model)
	model.make_move(1, 1)
	assert_signal_emitted(model, "board_updated", "board_updated signal should be emitted")
	assert_signal_emit_count(model, "board_updated", 1, "board_updated should be emitted exactly once")

## Test that turn_changed signal is emitted after move.
func test_turn_changed_signal_emitted():
	model = ModelClass.new()
	watch_signals(model)
	model.make_move(0, 0)
	assert_signal_emitted(model, "turn_changed", "turn_changed signal should be emitted")

## Test that game_won signal is emitted on win.
func test_game_won_signal_emitted():
	model = ModelClass.new()
	watch_signals(model)
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(0, 1)
	model.make_move(1, 1)
	model.make_move(0, 2)
	assert_signal_emitted(model, "game_won", "game_won signal should be emitted")

## Test that game_draw signal is emitted on draw.
func test_game_draw_signal_emitted():
	model = ModelClass.new()
	watch_signals(model)
	model.make_move(0, 0)
	model.make_move(1, 0)
	model.make_move(2, 0)
	model.make_move(1, 1)
	model.make_move(0, 1)
	model.make_move(2, 1)
	model.make_move(1, 2)
	model.make_move(0, 2)
	model.make_move(2, 2)
	assert_signal_emitted(model, "game_draw", "game_draw signal should be emitted")

## Test that game_reset signal is emitted on reset.
func test_game_reset_signal_emitted():
	model = ModelClass.new()
	watch_signals(model)
	model.reset_game()
	assert_signal_emitted(model, "game_reset", "game_reset signal should be emitted")
