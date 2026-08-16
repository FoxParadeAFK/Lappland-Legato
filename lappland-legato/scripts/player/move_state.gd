class_name MoveState extends State

func enter() -> void: pass

func physics_update(_delta: float) -> void:
	player.velocity.x = player.horizontal_input * player.HORIZONTAL_VELOCITY
	
	if player.horizontal_input == 0: player.transition_state(player.idle_state)
	elif player.vertical_input and player.is_on_floor(): player.transition_state(player.jump_state)
	elif not player.is_on_floor(): player.transition_state(player.in_air_state)

func exit() -> void: pass
