extends CharacterBody2D

@onready var sprite = $Sprites
@onready var animationplayer = $AnimationPlayer

func _ready() -> void:
    pass

func take_attack():
    print_debug("Enemy took an attack")

    # When hit by an attack, enemy will fall to a deactivated state
    animationplayer.play("damage")
    animationplayer.queue("death")
    