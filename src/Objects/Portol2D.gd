tool
extends Area2D

onready var  anim_player: AnimationPlayer = $AnimationPlayer    # $AnimationPlayer = get_node("AnimatonPlayer")

export  var next_scene: PackedScene

func _on_body_entered(body : PhysicsBody2D) -> void:    #atomatically called teleport function when enterd Prtal2D
	teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""

func teleport() -> void:
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")   #then uses yield to wait until the animation finishes
	get_tree().change_scene_to(next_scene)


