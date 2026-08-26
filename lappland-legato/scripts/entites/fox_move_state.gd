class_name FoxMoveState extends FoxState

const MOVE_DURATION_MIN: float = 0.75
const MOVE_DURATION_MAX: float = 3.75

func enter() -> void:
	fox.move_state_timer.start(randf_range(MOVE_DURATION_MIN, MOVE_DURATION_MAX))
	
func physics_update(_delta: float) -> void:
	fox.velocity.x = fox.facing_direction * 10
	
	if fox.move_state_timer.time_left == 0:
		fox.transition_state(fox.idle_state)
	
func exit() -> void:
	pass
