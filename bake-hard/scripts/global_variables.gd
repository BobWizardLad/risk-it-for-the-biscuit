extends Node

@export var difficulty: DIFFICULTY

var enemy_speed: int
var player_score: int # To be used...
var gnome_count: int # Gnome ~~kill~~ count
var player_retries: int

enum DIFFICULTY {
    EASY,
    NORMAL,
    HARD,
    GREGORIO_MUST_DIE # I WANT THIS SO BAD - Bob
}