@abstract class_name FoxState extends Node2D

var fox: Fox
var animation_name: String

func engage(_fox: Fox, _animation_name: String) -> void:
	fox = _fox
	animation_name = _animation_name
	
@abstract func enter() -> void
@abstract func physics_update(_delta: float) -> void
@abstract func exit() -> void
