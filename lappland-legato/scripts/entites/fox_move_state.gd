class_name FoxMoveState extends FoxState

func enter() -> void:
	pass
	
func physics_update(_delta: float) -> void:
	fox.velocity.x = fox.facing_direction * 10
	
func exit() -> void:
	pass
