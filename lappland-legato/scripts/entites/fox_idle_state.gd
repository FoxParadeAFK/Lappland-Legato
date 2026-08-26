class_name FoxIdleState extends FoxState

const IDLE_DURATION_MIN: float = 0.75
const IDLE_DURATION_MAX: float = 3.75

func enter() -> void:
	fox.velocity.x = 0
	fox.idle_state_timer.start(randf_range(IDLE_DURATION_MIN, IDLE_DURATION_MAX))
	
func physics_update(_delta: float) -> void:
	if fox.idle_state_timer.time_left == 0:
		fox.transition_state(fox.move_state)
	
func exit() -> void:
	pass
