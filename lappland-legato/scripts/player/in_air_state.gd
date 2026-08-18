class_name InAirState extends State

const VERTICAL_VELOCITY_HOVER_THRESHOLD: int = -45
const VERTICAL_VELOCITY_HOVER_GRAVITY: float = 0.35
const VERTICAL_VELOCITY_VARIABLE_GRAVITY: float = 0.8

func enter() -> void: pass

func physics_update(_delta: float) -> void:
	var gravity: float = player.GRAVITY
	if sign(player.velocity.y) == -1 and not player.vertical_input_held:
		player.velocity.y *= VERTICAL_VELOCITY_VARIABLE_GRAVITY
	if sign(player.velocity.y) == -1 and player.velocity.y >= VERTICAL_VELOCITY_HOVER_THRESHOLD:
		gravity *= VERTICAL_VELOCITY_HOVER_GRAVITY
	
	player.velocity.x = player.horizontal_input * player.HORIZONTAL_VELOCITY
	player.velocity.y += gravity * _delta
	
	if player.is_on_floor() and player.horizontal_input == 0: player.transition_state(player.idle_state)
	elif player.vertical_input and player.should_jump(): player.transition_state(player.jump_state)
	elif player.is_on_floor() and player.horizontal_input != 0: player.transition_state(player.move_state)

func exit() -> void:
	player.coyote_timer.stop()
