class_name JumpState extends State

var has_jumped: bool

func enter() -> void: 
	has_jumped = false
	
	player.velocity.y = -player.VERTICAL_VELOCITY
	
	has_jumped = true

func physics_update(_delta: float) -> void:
	if has_jumped: player.transition_state(player.in_air_state)

func exit() -> void: pass
