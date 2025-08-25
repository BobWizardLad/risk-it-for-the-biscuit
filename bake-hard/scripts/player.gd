class_name Player
extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var speed := 200

var is_dead = false

signal player_died

func _ready():
    animation_player.play("idle")
    # rotation = -PI / 2 # Face up initially
    pass

func take_attack():
    if !is_dead:
        print_debug("Player took an attack")
        set_process(false)
        set_process_input(false)
        is_dead = true
        player_died.emit()

func _unhandled_input(event):
    if !is_dead:
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
            var ray_length = 1000
            var start_pos = global_position
            var end_pos = start_pos + Vector2.RIGHT.rotated(rotation) * ray_length
            var space_state = get_world_2d().direct_space_state
            var ray_params = PhysicsRayQueryParameters2D.new()
            ray_params.from = start_pos
            ray_params.to = end_pos
            ray_params.exclude = [self]
            var result = space_state.intersect_ray(ray_params)
            if result:
                # You can access result.position, result.collider, etc.
                if result.collider is Enemy:
                    result.collider.take_attack()
                else:
                    print("Hit: ", result.collider)
            
            animation_player.play("fire")
            animation_player.queue("idle")

func _process(delta):
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        move_and_slide()
    
    # Make the player face the mouse position at all times
    var mouse_pos = get_global_mouse_position()
    rotation = (mouse_pos - global_position).angle()