extends Area2D

signal eaten

func _ready():
	pass

func _on_Spinach_area_entered(area):
	# Stop other leaves causing the score to jump
	if area.get_name() == "Player":
		emit_signal("eaten") # Tell everyone it's been eaten
		hide() # Hide the spinach
		queue_free() # Remove spinach now it's been eaten!

func game_over():
	hide()
	queue_free()