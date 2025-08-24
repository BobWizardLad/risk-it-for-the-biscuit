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
                    print("Hit an Enemy!")
                    result.collider.take_attack()
                else:
                    print("Hit: ", result.collider)
            
            animation_player.play("fire")
            animation_player.queue("idle")

func _process(delta):
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        position += velocity * delta
    # Make the player face the mouse position at all times
    var mouse_pos = get_global_mouse_position()
    rotation = (mouse_pos - global_position).angle()
