class_name Enemy
extends CharacterBody2D

@onready var sprite = $Sprites
@onready var animationplayer = $AnimationPlayer

var is_dead = false

func _ready() -> void:
    pass

func take_attack():
    if !is_dead:
        print_debug("Enemy took an attack")

        # When hit by an attack, enemy will fall to a deactivated state
        animationplayer.play("damage")
        animationplayer.queue("death")
        is_dead = true
        set_process(false)