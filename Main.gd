extends Node

export (PackedScene) var Spinach

var score

func _ready():
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
	add_child(spinach)
	spinach.position = Vector2(400, 400)
	spinach.connect("eaten", self, "_on_Spinach_eaten")

# Fired when leaf is collided with
func _on_Spinach_eaten():
	pass
