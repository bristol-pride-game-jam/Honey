extends CanvasLayer

# Tells the Main node that the Start button has been pressed
signal start_game

# Called when the player loses, showing the timer
func show_game_over():	
	# Wait 1 second before showing the start button
	yield(get_tree().create_timer(1), 'timeout')
	$MessageLabel.show()
	$StartButton.show()
	$ScoreLabel.hide()

# When the start button is pressed
func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	$Logo.hide()
	$ScoreLabel.show()
	emit_signal("start_game")

func change_score(score):
	$ScoreLabel.text = str(score)