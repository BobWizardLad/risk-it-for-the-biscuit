extends Node

signal activate_enemies
signal de_activate_enemies

@onready var death_text = $YouDied
@onready var player = $Player

func _ready() -> void:
	player.player_died.connect(_on_player_player_died)

func _on_activate_pressed() -> void:

	activate_enemies.emit()
	pass # Replace with function body.


func _on_de_activate_pressed() -> void:
	de_activate_enemies.emit()
	pass # Replace with function body.


func _on_player_player_died() -> void:
	de_activate_enemies.emit()
	death_text.visible = true
