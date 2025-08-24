extends CharacterBody2D

@onready var sprite = $Sprites

func _ready() -> void:
    pass

func take_attack():
    print_debug("Enemy took an attack")

    # When hit by an attack, enemy will fall to a deactivated state
    sprite.modulate = Color(1, 1, 1, 0.2)
    