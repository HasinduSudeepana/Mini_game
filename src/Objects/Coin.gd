extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
onready var colect_coin: AudioStreamPlayer2D = get_node("ColectCoin")
export var score: = 20

func _on_body_entered(body: PhysicsBody2D) -> void:
	PlayerData.score += score
	colect_coin.play()
	anim_player.play("fade_out")
	
