extends Control
@export var next_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().call_group("Player", "death_tween") # death_tween is called here just to give the feeling of player entering the door.
	AudioManager.level_complete_sfx.play()
	SceneTransition.load_scene(next_scene)


func _on_quit_pressed():
	get_tree().quit()
