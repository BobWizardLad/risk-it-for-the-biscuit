class_name Player
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed := 200

func _ready():
    animation_player.play("idle")
    # rotation = -PI / 2 # Face up initially
    pass

func _input(event):
        velocity = Vector2.ZERO
        if Input.is_action_pressed("ui_right"):
            velocity.x += 1
        if Input.is_action_pressed("ui_left"):
            velocity.x -= 1
        if Input.is_action_pressed("ui_down"):
            velocity.y += 1
        if Input.is_action_pressed("ui_up"):
            velocity.y -= 1
        
        if event.is_action_pressed("fire"):
            animation_player.play("fire")
            animation_player.queue("idle")

func _process(delta):
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        position += velocity * delta
    # Make the player face the mouse position at all times
    var mouse_pos = get_global_mouse_position()
    rotation = (mouse_pos - global_position).angle()
