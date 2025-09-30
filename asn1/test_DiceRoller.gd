## DiceRoller Unit Tests
## ----------------------
## This test suite uses GUT (Godot Unit Test framework) to validate the DiceRoller class.
## It checks constructor behavior, getters/setters, rolling functionality,
## and the dice results.

extends GutTest

# Preload the DiceRoller class for testing
var Dice = preload("res://DiceRoller.gd")
var dice = Dice

## Test that the constructor correctly initializes the number of dice and sides.
func test_constructor():
	dice = dice.new(2,6)
	var total_dice = dice.get_n_dice()
	assert_eq(total_dice, 2,"opps, wrong result")
	
## Test that the getter methods return the correct values after construction.
func test_getters():
	#dice = dice.new(6,6)
	var total_dice  = dice.get_n_dice()
	var total_side = dice.get_n_side()
	assert_eq(total_dice, 2,"opps, wrong result")
	assert_eq(total_side, 6,"opps, wrong result")
	
## Test that the setter methods properly update the number of dice and sides.	
func test_setters():
	#dice = dice.new(2,6)
	dice.set_n_dice(4)
	dice.set_n_side(12)
	var total_dice  = dice.get_n_dice()
	var total_side = dice.get_n_side()
	assert_eq(total_dice, 4,"opps, wrong result")
	assert_eq(total_side, 12,"opps, wrong result")

## Test that get_roll() generates the correct number of results
## and that the results are within valid dice ranges.	
func test_get_roll():
	#dice = dice.new(3,6)
	var rolls = dice.get_roll()
	assert_eq(rolls.size(),4,"Wrong number of rolled.")
	

	
	
	

	
