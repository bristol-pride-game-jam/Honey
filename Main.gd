extends Node

signal game_over

export (PackedScene) var Spinach
export var percentage_chance_to_spawn = 25
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
	$SpinachTimer.start()
	$GameOverTimer.start()
	$Background.visible = true

# Called on game over timeout
func game_over():
	emit_signal("game_over")
	$Player.stop()
	$SpinachTimer.stop()
	$GameOverTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$EndSound.play()
	$Background.visible = false

# Generate a new spinach leaf based on the chance to spawn
func _on_SpinachTimer_timeout():
	var chance_range = int(100 / percentage_chance_to_spawn)
	
	if ((randi() % chance_range) == 0):
		var spinach = Spinach.instance()
		add_child_below_node($Background, spinach)
		
		var rand_x = randi() % int(screen_size.x)
		var rand_y = randi() % int(screen_size.y) + min_height
		
		spinach.position = Vector2(rand_x, rand_y)
		
		var direction = rand_range(-PI / 4, PI / 4)
		spinach.rotation = direction
		
		# Let Main know when this particular tasty morsel is eaten
		spinach.connect("eaten", self, "_on_Spinach_eaten")
		
		# Let Spinach know when game is over to remove itself from the canvas
		self.connect("game_over", spinach, "game_over")

# Fired when leaf is collided with
func _on_Spinach_eaten():
	score += 1
	$HUD.change_score(score)

