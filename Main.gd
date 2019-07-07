extends Node

export (PackedScene) var Spinach

var score
var screen_size  # Size of the game window.
var min_height # Minimum height 

func _ready():
	# Ewwwwww!
	min_height = $Player.min_height
	screen_size = $Player.screen_size
	
	# Needs to be called in main so all random functions in the other nodes
	randomize()

# Let's us reset the game
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$Music.play()
	$StartTimer.start()
	$SpinachTimer.start()
	$ColorRect.visible = false
	$Background.visible = true

# -- UNUSED --
func game_over():
	$ScoreTimer.stop()
	$SpinachTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$EndSound.play()
	$ColorRect.visible = true
	$Background.visible = false

# -- UNUSED --
func _on_StartTimer_timeout():
	pass # Do nothing

# Generate a new spinach leaf
func _on_SpinachTimer_timeout():
	var spinach = Spinach.instance()
	add_child_below_node($Background, spinach)
	
	var rand_x = randi() % int(screen_size.x)
	var rand_y = randi() % int(screen_size.y) + min_height
	
	spinach.position = Vector2(rand_x, rand_y)
	
	var direction = rand_range(-PI / 4, PI / 4)
	spinach.rotation = direction
	
	spinach.connect("eaten", self, "_on_Spinach_eaten")

# Fired when leaf is collided with
func _on_Spinach_eaten():
	score += 1