extends Node

signal score_updated
signal player_died

var score: = 0 setget set_score     #The setget keyword is used to define custom setter methods
var deaths: =0 setget set_deaths
onready var colectCoin = $collect_coin

func reset() -> void:
	score = 0
	deaths = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
	
func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
