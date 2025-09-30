extends GutTest

var Dice = preload("res://DiceRoller.gd")
var dice = Dice

func test_constructor():

	dice = dice.new(2,6)
	var total_dice = dice.get_n_dice()
	assert_eq(total_dice, 2,"opps, wrong result")
	
