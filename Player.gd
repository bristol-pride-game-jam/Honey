extends Area2D

# Emits a signal when the collision is fired for the player
# Signal == Event methinks
signal hit

# "export" makes this valuable available in the inspector, so we can play about with it quickly
export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

# Called when the node enters the scene tree
# Feels like a constructor which can access state
func _ready():
	screen_size = get_viewport_rect().size # Get the current size of the screen
	hide() # Hides player by default when scene starts

# Called every frame, used for updating game elements
func _process(delta):
	var velocity = Vector2()  # The player's movement vector, initialises at (0,0)
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	# $ returns a child node at a relative path
	# $AnimatedSprite is a child node of Player, so we are accessing that
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	# clamp stops the player going out of the bounds of the screen
	# syntax is clamp(value, min, max)
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# Choose the correct animation based on whether we are going vertical or horizontal
	# Flips the sprite based on which direction we are going
	if velocity.x != 0:
	    $AnimatedSprite.animation = "right"
	    $AnimatedSprite.flip_v = false
	    # See the note below about boolean assignment
	    $AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
	    $AnimatedSprite.animation = "up"
	    $AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit") # Send out the signal (event) when collided with
	$CollisionShape2D.set_deferred("disabled", true)

# To be called when starting a new game
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false