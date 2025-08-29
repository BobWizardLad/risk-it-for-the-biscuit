extends Node

signal activate_enemies
signal de_activate_enemies

@export var death_text: RichTextLabel
@export var gnome_count: RichTextLabel
@export var reset_button: Button
@export var objective_anchor: ObjectivesAnchor
@onready var player = $Player


func _ready() -> void:
	player.player_died.connect(_on_player_player_died)
	
	# Objectives for each level
	objective_anchor.add_objective("Biscuit", "Find and steal the biscuit")
	objective_anchor.add_objective("Gnomes", "Serve the gnomes in your way")

func _on_activate_pressed() -> void:

	activate_enemies.emit()
	pass # Replace with function body.


func _on_de_activate_pressed() -> void:
	de_activate_enemies.emit()
	pass # Replace with function body.

func _on_enemy_death() -> void:
	GLOBAL_VARIABLES.gnome_count += 1

func _on_player_player_died() -> void:
	de_activate_enemies.emit()
	death_text.visible = true
	gnome_count.text = str("Gnome count was: " + str(GLOBAL_VARIABLES.gnome_count) + " gnomes handled.")
	gnome_count.visible = true
	reset_button.visible = true
	GLOBAL_VARIABLES.gnome_count = 0
	GLOBAL_VARIABLES.player_retries += 1

func _on_pickup_picked_up(pickup_name:String) -> void:
	if pickup_name == "biscuit":
		objective_anchor.remove_objective("Biscuit")
		objective_anchor.add_objective("Escape", "Get out")
