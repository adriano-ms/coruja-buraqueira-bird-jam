extends Area2D

# You can change these to your likings
@export var amplitude := 7
@export var frequency := 5
@export var points : int = 1

@onready var item_sprite = $AnimatedSprite2D

var time_passed = 0
var initial_position := Vector2.ZERO

func _ready():
	initial_position = position

func _process(delta):
	coin_hover(delta) # Call the coin_hover function
	item_animations()

# Coin Hover Animation
func coin_hover(delta):
	time_passed += delta
	
	var new_y = initial_position.y + amplitude * sin(frequency * time_passed)
	position.y = new_y

# Coin collected
func _on_body_entered(body):
	if body.is_in_group("Player"):
		AudioManager.coin_pickup_sfx.play()
		$Item.play()
		GameManager.add_stick(points)
		var tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
		await tween.finished
		queue_free()
		
func item_animations():
	item_sprite.play("Stick", 1.5)
