extends CanvasLayer

# Tells the Main node that the Start button has been pressed
signal start_game

# Called when the player loses, showing the timer
func show_game_over():	
	$MessageLabel.show()
	$StartButton.show()
	$Logo.show()

# When the start button is pressed
func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	$Logo.hide()
	$ScoreLabel.text = "Score: 0"
	$ScoreLabel.show()
	emit_signal("start_game")

func change_score(score):
	$ScoreLabel.text = "Score: " + str(score)