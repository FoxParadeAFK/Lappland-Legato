class_name FoxInAirState extends FoxState

func enter() -> void: pass

func physics_update(_delta: float) -> void:
	fox.velocity.y += fox.GRAVITY * _delta
	
	if fox.is_on_floor(): fox.transition_state(fox.move_state)

func exit() -> void: pass
