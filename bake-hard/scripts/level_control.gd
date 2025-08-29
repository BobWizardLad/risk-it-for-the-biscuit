extends Node

signal activate_enemies
signal de_activate_enemies

@export var death_text: RichTextLabel
@export var reset_button: Button
@export var objective_anchor: ObjectivesAnchor
@onready var player = $Player

var enemy_count: int = 0
var complete_objective_count: int = 0

func _ready() -> void:
	player.player_died.connect(_on_player_player_died)

	# Gather data for tracked variables
	enemy_count = get_tree().get_node_count_in_group("Enemy")
	
	# Objectives for each level
	objective_anchor.add_objective("Biscuit", "Find and steal the biscuit")
	objective_anchor.add_objective("Gnomes", "Serve the gnomes in your way")

func _on_activate_pressed() -> void:

	activate_enemies.emit()
	pass # Replace with function body.


func _on_de_activate_pressed() -> void:
	de_activate_enemies.emit()
	pass # Replace with function body.


func _on_player_player_died() -> void:
	de_activate_enemies.emit()
	death_text.visible = true
	reset_button.visible = true

func _on_pickup_picked_up(pickup_name:String) -> void:
	if pickup_name == "biscuit":
		complete_objective_count += 1
		objective_anchor.remove_objective("Biscuit")
		objective_anchor.add_objective("Escape", "Get out")
