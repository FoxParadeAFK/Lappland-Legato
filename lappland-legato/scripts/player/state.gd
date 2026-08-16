@abstract class_name State extends Node2D

var player: Player
var animation_name: String

func engage(_player: Player, _animation_name: String) -> void:
	player = _player
	animation_name = _animation_name
	
@abstract func enter() -> void
@abstract func physics_update(_delta: float) -> void
@abstract func exit() -> void
