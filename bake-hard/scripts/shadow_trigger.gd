class_name ShadowTrigger
extends Area2D

signal reveal

func _on_body_entered(body):
	if body is Player:
		emit_signal("reveal")

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))