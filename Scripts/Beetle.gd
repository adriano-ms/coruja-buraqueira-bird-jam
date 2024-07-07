extends CharacterBody2D

@onready var beetle_sprite = $AnimatedSprite2D

@export_category("Beetle Properties") # You can tweak these changes according to your likings
@export var back_range = 100
@export var speed = 100
@export var keep_running_time = 3
@export var gravity : float = 30
@export var points : int = 1

var backing : bool
var initial_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	default_movement()

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

func update():
	beetle_sprite.play("default")
	fall()
	move_and_slide()
	beetle_sprite.flip_h = !backing
	if(is_on_wall() and is_on_floor()):
		backing = true

func _on_collect_area_body_entered(body):
	if(body.is_in_group("Player")):
		GameManager.add_food(points)
		$Item.play()
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
		await tween.finished
		queue_free()
