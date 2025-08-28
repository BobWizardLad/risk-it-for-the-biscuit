class_name Enemy
extends CharacterBody2D

@onready var sprite = $Sprites
@onready var sprite_gnome = $Sprites/Sprite2D
@onready var animationplayer = $AnimationPlayer
@onready var vision = $Vision

var is_dead = false

@export var activation_source : Node2D
@export var speed := 80

func _ready() -> void:
	set_process(false)
	# Subscribe to parent's signal
	if activation_source.has_signal("activate_enemies"):
		activation_source.connect("activate_enemies", _activate)

	if activation_source.has_signal("de_activate_enemies"):
		activation_source.connect("de_activate_enemies", _deactivate)

func take_attack():
	if !is_dead and is_processing():
		print_debug("Enemy took an attack")

		# When hit by an attack, enemy will fall to a deactivated state
		animationplayer.play("damage")
		GLOBAL_FUNCTIONS.floating_text("Served", Color.RED, global_position)
		 # Emit signal to player to take damage
		animationplayer.queue("death")
		is_dead = true
		set_process(false)
		set_collision_layer(0)
		set_collision_mask(0)

func _process(_delta: float) -> void:
	if is_dead:
		return

	# Check if the player is in the enemy's vision
	var overlapping_bodies = vision.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Player:
			var start_pos = global_position
			var end_pos = body.global_position
			var space_state = get_world_2d().direct_space_state
			var ray_params = PhysicsRayQueryParameters2D.new()
			# 0b00000000_00000000_00000000_00000011
			ray_params.collision_mask = 3 # Collision mask 2, 1
			ray_params.from = start_pos
			ray_params.to = end_pos
			ray_params.exclude = [self]
			var result = space_state.intersect_ray(ray_params)
			if result:
				# You can access result.position, result.collider, etc.
				if result.collider is Player:
					var direction = (body.global_position - global_position).normalized()
					# Face the player
					look_at(body.global_position)
					# Walk towards the player
					velocity = direction * speed
					move_and_slide()

					var collision = get_last_slide_collision()
					if collision and collision.get_collider() is Player:
						collision.get_collider().take_attack()

func _activate() -> void:
	print("Activating enemy")
	sprite_gnome.frame = 1 # Activate gnomey arms
	set_process(true)
	
func _deactivate() -> void:
	print("Deactivating enemy")
	sprite_gnome.frame = 0 # Deactivate gnomey arms :(
	set_process(false)
