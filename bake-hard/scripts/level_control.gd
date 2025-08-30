extends Node

signal activate_enemies
signal de_activate_enemies

@export var death_text: RichTextLabel
@export var gnome_count: RichTextLabel
@export var reset_button: Button
@export var objective_anchor: ObjectivesAnchor
@export var jukebox: AudioStreamPlayer
@export var passive_music_track: AudioStream
@export var active_music_track: AudioStream
@export var aftermath_music_track: AudioStream
@onready var player = $Player

var gnomes_defeated: int
var total_gnomes: int

func _ready() -> void:
	player.player_died.connect(_on_player_player_died)

	# Gnomes in level; get count from scene group
	gnomes_defeated = 0
	total_gnomes = get_tree().get_node_count_in_group("Enemy")

	# Audio setup
	jukebox.stream = passive_music_track
	jukebox.play()

	# Objectives for each level
	objective_anchor.add_objective("Biscuit", "Find and steal the biscuit")
	objective_anchor.add_objective("Gnomes", "Serve the gnomes in your way")

func _process(_delta: float) -> void:
	if gnomes_defeated == total_gnomes:
		objective_anchor.remove_objective("Gnomes")
		jukebox.stream = aftermath_music_track
		jukebox.play()


func _on_activate_pressed() -> void:
	# Start the active music
	jukebox.stream = active_music_track
	jukebox.play()

	activate_enemies.emit()

func _on_de_activate_pressed() -> void:
	de_activate_enemies.emit()
	pass # Replace with function body.

func _on_enemy_death() -> void:
	GLOBAL_VARIABLES.gnome_count += 1

func _on_player_player_died() -> void:
	de_activate_enemies.emit()
	jukebox.stream = aftermath_music_track
	jukebox.play()
	death_text.visible = true
	gnome_count.text = str("Gnome count was: " + str(GLOBAL_VARIABLES.gnome_count) + " gnomes handled.")
	gnome_count.visible = true
	reset_button.visible = true
	GLOBAL_VARIABLES.gnome_count = 0
	GLOBAL_VARIABLES.player_retries += 1

func _on_pickup_picked_up(pickup_name:String) -> void:
	if pickup_name == "biscuit":
		objective_anchor.remove_objective("Biscuit")
		objective_anchor.add_objective("Escape", "Get out")

func _on_activate_custscene_begin() -> void:
	jukebox.stop()