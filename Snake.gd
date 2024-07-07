extends CharacterBody2D

@onready var snake_sprite = $AnimatedSprite2D
@onready var player = %Player

@export_category("Snake Properties") # You can tweak these changes according to your likings
@export var run_speed = 150
@export var keep_running_time = 3
@export var gravity : float = 30

var backing : bool
var initial_position = Vector2.ZERO
var is_running : bool
var running_time_elapsed : float
var current_animation = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	if(is_running):
		running_movement(delta)
		

func _on_detection_area_body_entered(body):
	if(body.is_in_group("Player")):
		current_animation = "default"
		is_running = true
		
func fall():
	if !is_on_floor():
		velocity.y += gravity

func running_movement(delta):
	if(player.position.x > position.x):
		self.velocity.x = +run_speed
		backing = false
	else:
		self.velocity.x = -run_speed
		backing = true	

func update():
	if(self.is_on_wall()):
		current_animation = "idle"
	snake_sprite.play(current_animation)
	fall()
	move_and_slide()
	snake_sprite.flip_h = !backing

func _on_collect_area_body_entered(body):
	if(body.is_in_group("Player")):
		current_animation = "attacking"
		is_running = false

func _on_collect_area_body_exited(body):
	if(body.is_in_group("Player")):
		current_animation = "default"
		
