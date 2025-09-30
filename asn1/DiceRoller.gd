extends RefCounted
class_name DiceRoller

##This class is a Dice rolling class.
##To use this class, you need to specify the number of dice, and the number of each dice.
## Class will have getter and setter and a roll function.


# Number of dice to roll
var n_Dice: int
# Number of sides on each dice
var n_Side: int
var result: Array[int] = []

## Constructor: Initializes a new DiceRoller instance.
## @param n_d The number of dice to be rolled.
## @param n_s The number of sides on each die .
func _init(n_d:int, n_s:int) -> void:
	n_Dice = n_d
	n_Side = n_s

##Sets the number of total dices 	
func set_n_dice(n:int) -> void:
	n_Dice = n
	
##Sets the number of dice sides with int.	
func set_n_side(n:int) -> void:
	n_Side = n
	
##Return the number of dices.
func get_n_dice() -> int:
	return n_Dice

##Return the number of dice's side
func get_n_side() -> int:
	return n_Side
	
	
##Simulates a roll and returns the results in an array.
##Return wiht an array that contains the result of each dices.	
func get_roll() -> Array[int]:
	result.clear()
	for i in range(n_Dice):
		var single_roll = randi_range(1,n_Side)
		result.append(single_roll)
	return result
	
func show_result() -> void:
	var sum = 0
	for i in result:
		sum = sum + i
	print("Your toal rolling result = " + sum)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
