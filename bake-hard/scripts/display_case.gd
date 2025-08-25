extends Node2D

signal level_begin

var player_in_area = false

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		if player_in_area:
			break_display_case()

func break_display_case():
	# Do stuff to telegraph the case breaking and the level start
	level_begin.emit()

func _on_start_area_body_entered(body: Node) -> void:
	if body is Player:
		player_in_area = true

func _on_start_area_body_exited(body: Node) -> void:
	if body is Player:
		player_in_area = false