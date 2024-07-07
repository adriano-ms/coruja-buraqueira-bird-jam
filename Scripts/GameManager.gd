# This script is an autoload, that can be accessed from any other script!

extends Node2D

var time_limit : float = 20.0

var total_food = 0
var total_stick = 0
var total_manure = 0

var food : int = 0
var stick : int = 0
var manure : int = 0

var pause : bool = true

func add_food(amount : int):
	food += amount

func add_stick(amount : int):
	stick += amount

func add_manure(amount : int):
	manure += amount

func _process(delta):
	if(!pause):
		time_limit -= delta
		if(time_limit <= 0):
			time_limit = 0
			pause = true
			total_food += food
			food = 0
			total_stick += stick
			stick = 0
			total_manure += manure
			manure = 0
	
func _start_timer():
	pause = false
	
func _stop_timer():
	pause = true

# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
