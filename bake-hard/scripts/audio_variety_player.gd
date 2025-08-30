extends AudioStreamPlayer2D

## Holds a list of audio sources and samples from them at random; built for
## a sample that wants a variety of sfx for one instance such as an enemy falling.

@export var audio_catalog : Array[AudioStream]

var rng : RandomNumberGenerator

func _ready() -> void:
    rng = RandomNumberGenerator.new()
    rng.seed = int(Time.get_date_string_from_system())

func play_audio_stream() -> void:
    stream = audio_catalog[rng.randi_range(0, 1)]
    play()