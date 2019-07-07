extends Area2D

signal eaten

func _ready():
	pass

func _on_Spinach_area_entered(area):
	emit_signal("eaten")
