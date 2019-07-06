extends Node

# Lets us choose the Mob node we want
# PackageScene is a high level abstraction over different scene types
# This lets us load the Mob scene from the file system here
export (PackedScene) var Mob
var score

func _ready():
	# Needs to be called in main so all random functions in the other nodes
	randomize()

# Let's us reset the game
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$StartTimer.start()

# Trigged by the "hit" signal on the player
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

# When the start timer finishes (one shot)
func _on_StartTimer_timeout():
	# Start the other 2 timers
	$MobTimer.start()
	$ScoreTimer.start()

# When the score timer loops
func _on_ScoreTimer_timeout():
	# You score by surviving, 1 point per second
	score += 1
	$HUD.update_score(score)

# When the mob timer loops
func _on_MobTimer_timeout():
	# Choose a random location on Path2D, which is at the borders of the game area
	$MobPath/MobSpawnLocation.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

