class_name FoxMoveState extends FoxState

const MOVE_DURATION_MIN: float = 1.00
const MOVE_DURATION_MAX: float = 2.00

var should_jump: bool
var wants_to_jump: bool

func enter() -> void:
	fox.move_state_timer.start(randf_range(MOVE_DURATION_MIN, MOVE_DURATION_MAX))
	should_jump = false
	wants_to_jump = false
	
func physics_update(_delta: float) -> void:
	fox.velocity.x = fox.facing_direction * 15
	
	var leap_condition: bool = fox.lower_wall_ray_cast.get_collider() != null and fox.upper_wall_ray_cast.get_collider() == null
	if not should_jump and leap_condition and (abs(fox.lower_wall_ray_cast.get_collision_point().x - fox.global_position.x) >= 17):
		should_jump = true
		wants_to_jump = true if randf() > 0.01 else false
	
	if wants_to_jump:
		fox.transition_state(fox.leap_state)
	elif fox.move_state_timer.time_left == 0:
		fox.transition_state(fox.idle_state)
	elif not fox.is_on_floor():
		fox.transition_state(fox.in_air_state)
	
func exit() -> void:
	pass
