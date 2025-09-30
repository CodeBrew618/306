extends GutTest

var Dice = preload("res://DiceRoller.gd")
var dice = Dice

func test_constructor():
	dice = dice.new(2,6)
	var total_dice = dice.get_n_dice()
	assert_eq(total_dice, 2,"opps, wrong result")
	
	
func test_getters():
	#dice = dice.new(6,6)
	var total_dice  = dice.get_n_dice()
	var total_side = dice.get_n_side()
	assert_eq(total_dice, 2,"opps, wrong result")
	assert_eq(total_side, 6,"opps, wrong result")
	
	
func test_setters():
	#dice = dice.new(2,6)
	dice.set_n_dice(4)
	dice.set_n_side(12)
	var total_dice  = dice.get_n_dice()
	var total_side = dice.get_n_side()
	assert_eq(total_dice, 4,"opps, wrong result")
	assert_eq(total_side, 12,"opps, wrong result")
	
func test_get_roll():
	#dice = dice.new(3,6)
	var rolls = dice.get_roll()
	assert_eq(rolls.size(),4,"Wrong number of rolled.")
	

	
	
	

	
