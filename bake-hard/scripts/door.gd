extends Node2D

## This is set if you want the door to lock at the start rather than unlock.
@export var lock_door_at_start := false
@export var activation_source : Node2D

@onready var sprite = $Sprite
@onready var interact_area = $InteractArea
@onready var collision_area = $DoorCollision

var player_in_area = false
var door_locked = true

func _ready() -> void:
	interact_area.body_entered.connect(_on_interact_area_body_entered)
	interact_area.body_exited.connect(_on_interact_area_body_exited)

	if activation_source.has_signal("activate_enemies"):
		activation_source.connect("activate_enemies", _activate)

	if activation_source.has_signal("de_activate_enemies"):
		activation_source.connect("de_activate_enemies", _deactivate)
	
	if lock_door_at_start:
		door_locked = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		if player_in_area:
			if !door_locked:
				_open_door()
			elif lock_door_at_start:
				GLOBAL_FUNCTIONS.floating_text("Defeat all Enemies!", Color.RED, global_position)
			else:
				GLOBAL_FUNCTIONS.floating_text("Locked", Color.RED, global_position)

func _on_interact_area_body_entered(body: Node2D) -> void:
	# print("something entered interact area")
	if body is Player:
		sprite.modulate = Color(1, 0.8, 0.8) # Change color to indicate interaction
		player_in_area = true

func _on_interact_area_body_exited(body: Node2D) -> void:
	# print("something exited interact area")
	if body is Player:
		sprite.modulate = Color(1, 1, 1) # Reset color
		player_in_area = false

func _open_door() -> void:
	sprite.frame = 1 # Assuming frame 1 is the open door sprite
	
	collision_area.set_collision_layer(0)
	interact_area.set_collision_mask(0)

	sprite.modulate = Color(1, 1, 1) # Reset color

func _close_door() -> void:
	sprite.frame = 0 # Assuming frame 0 is the closed door sprite

	collision_area.set_collision_layer(1)
	interact_area.set_collision_mask(2)

func _activate() -> void:
	if lock_door_at_start:
		_close_door()
		door_locked = true
	else:
		door_locked = false

func _deactivate() -> void:
	door_locked = false
