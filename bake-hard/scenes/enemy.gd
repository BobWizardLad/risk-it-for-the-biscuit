class_name Enemy
extends CharacterBody2D

@export var signal_control: Node2D

@onready var sprite = $Sprites
@onready var animationplayer = $AnimationPlayer
@onready var vision = $Vision

var is_dead = false

@export var speed := 80

func _ready() -> void:
	set_process(false)
	# Subscribe to parent's signal
	if signal_control.has_signal("activate_enemies"):
		signal_control.connect("activate_enemies", _activate)

	if signal_control.has_signal("de_activate_enemies"):
		signal_control.connect("de_activate_enemies", _deactivate)

func take_attack():
	if !is_dead and is_processing():
		print_debug("Enemy took an attack")

		# When hit by an attack, enemy will fall to a deactivated state
		animationplayer.play("damage")
		animationplayer.queue("death")
		is_dead = true
		set_process(false)
		set_collision_layer(0)
		set_collision_mask(0)

func _process(delta: float) -> void:
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
	set_process(true)
	
func _deactivate() -> void:
	print("Deactivating enemy")
	set_process(false)
