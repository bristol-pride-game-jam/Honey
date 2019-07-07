extends Area2D

# "export" makes this valuable available in the inspector, so we can play about with it quickly
export var speed = 400  # How fast the player will move (pixels/sec).

# To stop sprite going over edges
export var sprite_size = Vector2(94, 45)
export var min_height = 450

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
	position.x = clamp(position.x, (0 + sprite_size.x), (screen_size.x - sprite_size.x))
	position.y = clamp(position.y, (0 + min_height + sprite_size.y), (screen_size.y - sprite_size.y))

	# Flips the sprite based on which direction it is going
	if velocity.x != 0:
	    $AnimatedSprite.animation = "right"
	    $AnimatedSprite.flip_v = false
	    # See the note below about boolean assignment
	    $AnimatedSprite.flip_h = velocity.x < 0

# To be called when starting a new game
func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false