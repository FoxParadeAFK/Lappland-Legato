class_name IdleState extends State

func enter() -> void:
	player.velocity.x = 0

func physics_update(_delta: float) -> void:
	if player.horizontal_input != 0: player.transition_state(player.move_state)
	elif not player.is_on_floor(): player.transition_state(player.in_air_state)

func exit() -> void: pass
