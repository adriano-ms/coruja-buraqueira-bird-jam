extends CharacterBody2D

@onready var mice_sprite = $AnimatedSprite2D

@export_category("Mice Properties") # You can tweak these changes according to your likings
@export var back_range = 50
@export var speed = 150
@export var run_speed = 300
@export var keep_running_time = 3
@export var gravity : float = 30
@export var points : int = 2

var backing : bool
var initial_position = Vector2.ZERO
var is_running : bool
var player_position = Vector2.ZERO
var running_time_elapsed : float

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	if(is_running):
		running_movement(delta);
	else:
		default_movement()

func _on_detection_area_body_entered(body):
	if(body.is_in_group("Player")):
		is_running = true
		player_position = body.position

func fall():
	if !is_on_floor():
		velocity.y += gravity

func default_movement():
	if(position.x > initial_position.x + back_range):
			backing = true
	if(position.x < initial_position.x - back_range):
		backing = false
	if(backing):
		self.velocity.x = -speed
	else:
		self.velocity.x = speed

func running_movement(delta):
	running_time_elapsed += delta
	if(running_time_elapsed >= keep_running_time):
		initial_position = position
		running_time_elapsed = 0
		is_running = false
	if(player_position.x > position.x):
		self.velocity.x = -run_speed
		backing = true
	else:
		self.velocity.x = run_speed
		backing = false	

func update():
	mice_sprite.play("default")
	fall()
	move_and_slide()
	mice_sprite.flip_h = !backing
	if(is_on_wall() and is_on_floor()):
		velocity.y = -500

func _on_collect_area_body_entered(body):
	if(body.is_in_group("Player")):
		GameManager.add_food(points)
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
		await tween.finished
		queue_free()
