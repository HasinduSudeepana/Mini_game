#extends "res://src/Actors/Actor.gd"
extends Actor

export var score: = 100
#onready var death: AudioStreamPlayer2D = get_node("Death")
onready var deathSound: AudioStreamPlayer2D = get_node("Death")

func _ready() ->void:
	set_physics_process(false)
	_velocity.x = -speed.x     #enermy move to left
	
func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:    #player landed the top
	
	if body.global_position.y > get_node("StompDetector").global_position.y:  #check player position above the StompDetector
		return
	get_node("CollisionShape2D").disabled = true    # below the StompDetector
	deathSound.play()
	die()  #destroy enemy
	

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():   #enemy is colliding in the wall
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	queue_free()
	PlayerData.score += score

