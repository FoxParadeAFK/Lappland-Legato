class_name Player extends CharacterBody2D

var current_state: State
func transition_state(_transitioning_state: State) -> void:
	if current_state != null: current_state.exit()
	
	print("Time: %5s State: %s" % [Time.get_ticks_msec(), _transitioning_state.animation_name])
	current_state = _transitioning_state
	current_state.enter()
	
var idle_state: IdleState

func _ready() -> void:
	idle_state = get_node_or_null("FiniteStateMachine/IdleState")
	idle_state.engage(self, "idle")
	transition_state(idle_state)

func _physics_process(_delta: float) -> void:
	current_state.physics_update(_delta)
	
	move_and_slide()
