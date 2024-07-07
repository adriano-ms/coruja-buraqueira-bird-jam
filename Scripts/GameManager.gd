# This script is an autoload, that can be accessed from any other script!

extends Node2D

@onready var player : CharacterBody2D = %Player
@onready var spawn_point : Marker2D = %SpawnPoint

var time_limit : float = 5.0

var current_level : int = 1

var total_food = 0
var total_stick = 0
var total_manure = 0

var food : int = 0
var stick : int = 0
var manure : int = 0

var pause : bool = true
var is_player_in_house : bool = false

func add_food(amount : int):
	food += amount

func add_stick(amount : int):
	stick += amount
	
func resource_lost():
	food -= RandomNumberGenerator.new().randi_range(0, 4)
	stick -= RandomNumberGenerator.new().randi_range(0, 3)

func _next_level():
	if(current_level < 4):
		current_level += 1

func _process(delta):
	if(!pause):
		time_limit -= delta
		if(time_limit <= 0):
			time_limit = 0
			pause = true
			if(!is_player_in_house):
				resource_lost()
			_sum_points()
			if(current_level < 4):
				#player.position = spawn_point.position
				_next_level()
				time_limit = 5.0
				pause = false
	
func _start_timer():
	pause = false
	
func _stop_timer():
	pause = true

func _sum_points():
	total_food += food
	food = 0
	total_stick += stick
	stick = 0
	total_manure += manure
	manure = 0

# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
