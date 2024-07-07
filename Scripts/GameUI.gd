extends Control

@onready var food_texture = %Food/FoodTexture
@onready var food_label = %Food/FoodLabel

@onready var stick_texture = %Stick/StickTexture
@onready var stick_label = %Stick/StickLabel

@onready var timer_label = %Timer/TimerLabel

func _process(_delta):
	# Set the score label text to the score variable in game maanger script
	food_label.text = "x %d" % GameManager.food
	stick_label.text = "x %d" % GameManager.stick
	timer_label.text = "Time: %d seconds" % GameManager.time_limit
	
