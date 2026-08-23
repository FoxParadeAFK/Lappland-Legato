class_name Fox extends CharacterBody2D

var current_state: FoxState
var idle_state: FoxIdleState
func transition_state(_transitioning_state: FoxState) -> void:
	if current_state != null: current_state.exit()
	
	current_state = _transitioning_state
	print("Time: %5s Fox State: %s" % [Time.get_ticks_msec(), current_state.animation_name])
	current_state.enter()

func get_state(_state_path: NodePath, _animation_name: String) -> FoxState:
	var state: FoxState = get_node_or_null(_state_path)
	if state != null: state.engage(self, _animation_name)
	
	return state

var facing_direction: int

func _ready() -> void:
	facing_direction = 1
	
	idle_state = get_state("FiniteStateMachine/FoxIdleState", "idle")
	transition_state(idle_state)
