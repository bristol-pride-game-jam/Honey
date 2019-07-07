extends Area2D

signal eaten

func _ready():
	pass

func _on_Spinach_area_entered(area):
	emit_signal("eaten") # Tell everyone it's been eaten
	hide() # Hide the spinach
	$CollisionShape2D.disabled = true # Stop any more collisions
	queue_free() # Remove spinach now it's been eaten!
