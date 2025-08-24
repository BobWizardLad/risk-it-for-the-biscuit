class_name FloatingDamageNumber
extends Node
@onready var label: RichTextLabel = $RichTextLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func setup(text: String, color: Color) -> void:
	# Set the damage value and color for the floating damage number
	label.bbcode_text = "[color=%s]%s[/color]" % [color.to_html(), text]

func animate() -> void:
	# Start the animation for the floating damage number
	animation_player.play("float_up")

func destroy() -> void:
	# Clean up the floating damage number when it is no longer needed
	queue_free()
