class_name Shadow
extends Sprite2D

@export var shadow_triggers: Array[ShadowTrigger]

func _ready() -> void:
	for trigger in shadow_triggers:
		trigger.connect("reveal", Callable(self, "reveal"))

func reveal():
	visible = false