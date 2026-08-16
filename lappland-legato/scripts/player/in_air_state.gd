class_name InAirState extends State

func enter() -> void: pass

func physics_update(_delta: float) -> void:
	player.velocity.x = player.horizontal_input * 100
	player.velocity.y += 650 * _delta
	
	if player.is_on_floor() and player.horizontal_input == 0: player.transition_state(player.idle_state)
	elif player.is_on_floor() and player.horizontal_input != 0: player.transition_state(player.move_state)

func exit() -> void: pass
