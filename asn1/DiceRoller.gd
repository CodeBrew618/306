extends RefCounted
class_name DiceRoller

##

var n_Dice: int
var n_Side: int


func _init(n_d:int, n_s:int) -> void:
	n_Dice = n_d
	n_Side = n_s
	
func set_n_dice(n:int) -> void:
	n_Dice = n
	
func set_n_side(n:int) -> void:
	n_Side = n
	
func get_n_dice(n:int) -> int:
	return n_Dice
	
func get_n_side(n:int) -> int:
	return n_Side
	
func get_roll() -> Array[int]:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
