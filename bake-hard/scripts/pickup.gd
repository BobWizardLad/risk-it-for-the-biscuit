extends Node2D

## Name of the item being picked up: Objectives will refer to this object by the pickup_name
@export var pickup_name: String

@onready var pickup_area: Area2D = $PickupRange

signal picked_up(pickup_name: String)

func _on_player_picked(_entered_body: Node2D):
    # When detecting the player, emit a signal with my name to the scene and delete myself
    picked_up.emit(pickup_name)
    queue_free()