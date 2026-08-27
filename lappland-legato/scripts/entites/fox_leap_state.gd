class_name FoxLeapState extends FoxState

var has_leaped: bool

func enter() -> void:
	has_leaped = false
	fox.velocity = Vector2(70 * fox.facing_direction, -90)
	has_leaped = true

func physics_update(_delta: float) -> void: 
	if has_leaped:
		fox.transition_state(fox.in_air_state)

func exit() -> void: pass
