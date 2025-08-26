extends Control

@onready var animation_player = $AnimationPlayer

signal animation_finished

func _ready() -> void:
	pass

# Pass the animation player signal out into the root node so that levels can use it
func _on_animation_finished(anim_name) -> void:
	animation_finished.emit()

func play_start_animation() -> void:
	animation_player.play("test_begin")
