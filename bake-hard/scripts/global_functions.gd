extends Node

func floating_text(text: String, color: Color, position: Vector2) -> void:
	var floating_damage = load("res://scenes/floating_damage_number.tscn").instantiate()
	get_tree().current_scene.add_child(floating_damage)
	floating_damage.setup(text, color)
	floating_damage.position = position
	floating_damage.animate()
