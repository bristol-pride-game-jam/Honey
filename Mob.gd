extends RigidBody2D

# "export" makes this valuable available in the inspector, so we can play about with it quickly
export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.

var mob_types = ["walk", "swim", "fly"] # Matches animations in the AnimatedSprite

# Runs when the node enters the scene tree
func _ready():
	# "randi" creates a random integer
	#  So the below chooses a random 1 of the 3 sprites as the animation
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	
# When the node leaves the screen, delete it
# Queues the node for deletion, including all child nodes
func _on_Visibility_screen_exited():
	queue_free()