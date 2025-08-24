class_name Enemy
extends CharacterBody2D

@onready var sprite = $Sprites
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
		animationplayer.queue("death")
		is_dead = true
		set_process(false)

func _process(_delta: float) -> void:
	if is_dead:
		return

	# Check if the player is in the enemy's vision
	var overlapping_bodies = vision.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Player:
			# Face the player
			look_at(body.global_position)
			# Walk towards the player
			var direction = (body.global_position - global_position).normalized()
			velocity = direction * speed
			move_and_slide()

			var collision = get_last_slide_collision()
			if collision and collision.get_collider() is Player:
				collision.get_collider().take_attack()
			pass

func _activate() -> void:
	print("Activating enemy")
	set_process(true)
	
func _deactivate() -> void:
	print("Deactivating enemy")
	set_process(false)
