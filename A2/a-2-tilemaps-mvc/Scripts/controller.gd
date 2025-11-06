class_name Controller
extends Node2D
# init MVC Components
var model: Model
var view: View

@onready var turn_label: Label = $TurnLabel
@onready var message_panel: Panel = $MessagePanel
@onready var message_label: Label = $MessagePanel/MessageLabel
@onready var new_game_button: Button = $MessagePanel/NewGameButton

func _ready() -> void:
	model = Model.new()
	
	# Get reference to View
	view = $TileMapLayer as View
	view.model = model
	
	# Connect model signals to view (Observer pattern)
	model.board_updated.connect(view.on_board_updated)
	model.game_reset.connect(view.on_game_reset)
	
	# Connect model signals to controller UI updates
	model.turn_changed.connect(on_turn_changed)
	model.game_won.connect(on_game_won)
	model.game_draw.connect(on_game_draw)
	model.game_reset.connect(on_game_reset)
	
	# Connect button signal
	new_game_button.pressed.connect(on_new_game_pressed)
	
	# Initialize UI
	update_turn_label()
	message_panel.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			handle_click(event.position)

func handle_click(world_pos: Vector2) -> void:
	# Convert world position to board coordinates
	var board_pos = view.world_to_board(world_pos)
	
	model.make_move(board_pos.x, board_pos.y)

func on_turn_changed(current_player: int) -> void:
	update_turn_label()

func update_turn_label() -> void:
	var player_name = "X" if model.current_player == Model.Player.X else "O"
	turn_label.text = "Current Turn: " + player_name

func on_game_won(winner: int) -> void:
	var winner_name = "X" if winner == Model.Player.X else "O"
	message_label.text = "Player " + winner_name + " Wins!"
	message_panel.show()

func on_game_draw() -> void:
	message_label.text = "Cat Wins! (Draw)"
	message_panel.show()

func on_game_reset() -> void:
	message_panel.hide()
	update_turn_label()

func on_new_game_pressed() -> void:
	model.reset_game()
