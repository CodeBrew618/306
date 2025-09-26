class_name Player

extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

@export var speed = 400

func _process(delta: float) -> void:
	if Input.is_action_pressed("right"):
		_animated_sprite.play("Walk-right")
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("Walk-left")
	elif Input.is_action_pressed("up"):
		_animated_sprite.play("Walk-up")
	elif Input.is_action_pressed("down"):
		_animated_sprite.play("Walk-up")		
	else:
		_animated_sprite.stop()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
