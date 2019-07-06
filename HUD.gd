extends CanvasLayer

# Tells the Main node that the Start button has been pressed
signal start_game

# Show the center message and start a timer to hide it in 2 seconds
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

# Called when the player loses, showing the timer
func show_game_over():
	show_message("Game Over")
	 # Wait until the timeout event of the timer before continuing
	yield($MessageTimer, "timeout")
	
	
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	
	# Wait 1 second before showing the start button
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()

# When the start button is pressed
func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
# When the message timeout expires (one shot)
func _on_MessageTimer_timeout():
	$MessageLabel.hide()
