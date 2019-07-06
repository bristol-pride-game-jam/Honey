extends Node

var score

func _ready():
	# Needs to be called in main so all random functions in the other nodes
	randomize()

# Let's us reset the game
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$HUD.show_message("Get Ready")
	$Music.play()
	$StartTimer.start()

# Trigged by the "hit" signal on the player
func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$EndSound.play()

# When the start timer finishes (one shot)
func _on_StartTimer_timeout():
	pass # Do nothing
