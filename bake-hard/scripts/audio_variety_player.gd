extends AudioStreamPlayer2D

## Holds a list of audio sources and samples from them at random; built for
## a sample that wants a variety of sfx for one instance such as an enemy falling.

@export var audio_catalog : Array[AudioStream]

var rng : RandomNumberGenerator

func _ready() -> void:
    rng = RandomNumberGenerator.new()
    rng.randomize()

func play_audio_stream() -> void:
    stream = audio_catalog[rng.randi_range(-1, audio_catalog.size() - 1)] # Play any track in the catalog
    play()