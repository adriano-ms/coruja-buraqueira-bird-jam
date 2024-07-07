# This script is an autoload, that can be accessed from any other script!

extends Node2D

var food : int = 0
var stick : int = 0
var manure : int = 0

func add_food(amount : int):
	food += amount

func add_stick(amount : int):
	stick += amount

func add_manure(amount : int):
	manure += amount

# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
