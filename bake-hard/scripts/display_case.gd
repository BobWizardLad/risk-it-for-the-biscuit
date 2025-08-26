extends Node2D

@onready var interact_label = $InteractLabel

signal level_begin
signal start_break_cutscene

var player_in_area = false

func _ready() -> void:
	interact_label.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		if player_in_area:
			break_display_case()

func break_display_case():
	# Do stuff to telegraph the case breaking and the level start
	start_break_cutscene.emit()

func _on_start_area_body_entered(body: Node) -> void:
	if body is Player:
		interact_label.show()
		player_in_area = true

func _on_start_area_body_exited(body: Node) -> void:
	if body is Player:
		interact_label.hide()
		player_in_area = false

func _break_cutscene_finished() -> void:
	level_begin.emit()