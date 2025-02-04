extends Area2D

# Define the next scene to load in the inspector
@onready var spawn_point : Marker2D = %Level/SpawnPoint
@onready var player : CharacterBody2D = %Player

# Load next level scene when player collide with level finish door.
func _on_body_entered(body):
	if body.is_in_group("Player"):
		GameManager.is_player_in_house = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		GameManager.is_player_in_house = false
