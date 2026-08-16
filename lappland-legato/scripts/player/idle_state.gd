class_name IdleState extends State

func enter() -> void:
	player.velocity.x = 0

func physics_update(_delta: float) -> void:
	if player.horizontal_input != 0: player.transition_state(player.move_state)

func exit() -> void: pass
