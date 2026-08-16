class_name MoveState extends State

func enter() -> void: pass

func physics_update(_delta: float) -> void:
	player.velocity.x = player.horizontal_input * 100
	
	if player.horizontal_input == 0: player.transition_state(player.idle_state)

func exit() -> void: pass
