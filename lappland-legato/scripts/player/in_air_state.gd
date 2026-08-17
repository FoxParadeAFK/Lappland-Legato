class_name InAirState extends State

func enter() -> void: pass

func physics_update(_delta: float) -> void:
	var gravity: float = player.GRAVITY
	if sign(player.velocity.y) == -1 and player.vertical_input_released:
		player.velocity.y *= 0.6
		player.vertical_input_released = false
		player.vertical_input_released_buffer_timer.stop()
	if sign(player.velocity.y) == -1 and player.velocity.y >= -45:
		gravity *= 0.35
	
	player.velocity.x = player.horizontal_input * player.HORIZONTAL_VELOCITY
	player.velocity.y += gravity * _delta
	
	if player.is_on_floor() and player.horizontal_input == 0: player.transition_state(player.idle_state)
	elif player.is_on_floor() and player.horizontal_input != 0: player.transition_state(player.move_state)

func exit() -> void: pass
