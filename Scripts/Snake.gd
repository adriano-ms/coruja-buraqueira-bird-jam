extends CharacterBody2D

@onready var snake_sprite = $AnimatedSprite2D
@onready var player : CharacterBody2D = %Player

@export_category("Snake Properties") # You can tweak these changes according to your likings
@export var run_speed = 150
@export var keep_running_time = 0.5
@export var gravity : float = 30

var backing : bool
var initial_position = Vector2.ZERO
var is_running : bool
var current_animation = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	if(is_running):
		running_movement()
		

func _on_detection_area_body_entered(body):
	if(body.is_in_group("Player")):
		current_animation = "default"
		is_running = true
		
func fall():
	if !is_on_floor():
		velocity.y += gravity

func running_movement():
	if(player.position.x > self.position.x):
		self.velocity.x = run_speed
		backing = false
	else:
		self.velocity.x = -run_speed
		backing = true

func update():
	snake_sprite.play(current_animation)
	fall()
	move_and_slide()
	snake_sprite.flip_h = !backing

func _on_collect_area_body_entered(body):
	if(body.is_in_group("Player")):
		current_animation = "attacking"
		

func _on_collect_area_body_exited(body):
	if(body.is_in_group("Player")):
		current_animation = "default"
		
