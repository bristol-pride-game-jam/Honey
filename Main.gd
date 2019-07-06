extends Node

# Lets us choose the Mob node we want
# PackageScene is a high level abstraction over different scene types
# This lets us load the Mob scene from the file system here
export (PackedScene) var Mob
var score

func _ready():
	randomize()

# Trigged by the "hit" signal on the player
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

# Let's us reset the game
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()