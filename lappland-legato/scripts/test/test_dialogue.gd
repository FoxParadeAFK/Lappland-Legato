class_name TestDialogue extends Node2D

@export var manuscript: Manuscript

func _physics_process(_delta: float) -> void:
	var interaction_input: bool = Input.is_action_just_pressed("ui_accept")
	
	if interaction_input:
		manuscript.read_manuscript()
