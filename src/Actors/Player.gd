extends Actor

export var stomp_impulse: = 1000.0
onready var player = $AnimationPlayer
#onready var death_enemy: AudioStreamPlayer2D = get_node("DeathPlayer")

func _ready():
	player.play("Idle")

func _on_EnemyDetector_area_entered(area: Area2D) -> void:     #used for detecting collisions with this enemy.
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) ->void:    #t's used to detect when another game object's physics body enters the enemy's detection area.
	
	die()

#automatically call actors this function
func _physics_process(delta: float) -> void:
	var is_jump_interruped: = Input.is_action_just_released("jump") and _velocity.y < 0.0   #stops the vertical velocity.
	var direction: = get_direction()
	#colectCoin.play()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interruped)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
 

func get_direction() -> Vector2:
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var x_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_direction = -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	
	if  right:
		# Play the "run" animation when moving right
		player.play("run")
		$Player.scale.x = 1.0
	elif left:
		# Play the "idle" animation when moving left
		player.play("run")
		$Player.scale.x = -1.0
	else:
		if is_on_floor():
			# Play the "idle" animation when not moving and on the ground
			player.play("Idle")
	return Vector2(x_direction, y_direction)


func calculate_move_velocity(  
	   # the movement velocity for the enemy:ss
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interruped: bool
	) -> Vector2:
	
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()  #return the delta value of physicss process
	if direction.y == -1.0:
		out.y = speed.y * direction.y    # y component jump speed
	if is_jump_interruped:   # after jumped, stop vertically vilocity
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity              #calculate the velocity change when the enemy is stomped.
	out.y = -impulse
	return out

func die() -> void:
	PlayerData.deaths += 1
	#queue_free()
	


