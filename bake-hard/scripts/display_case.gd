extends Node2D

signal level_begin

func _ready() -> void:
	break_display_case()

func break_display_case():
	# Do stuff to telegraph the case breaking and the level start
	level_begin.emit()
