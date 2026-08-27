class_name Fox extends CharacterBody2D

var current_state: FoxState
var idle_state: FoxIdleState
var move_state: FoxMoveState
var in_air_state: FoxInAirState
var leap_state: FoxLeapState
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
@onready var front_ground_ray_cast: RayCast2D = $"RayCast/FrontGroundRayCast"
@onready var back_ground_ray_cast: RayCast2D = $"RayCast/BackGroundRayCast"
@onready var upper_wall_ray_cast: RayCast2D = $"RayCast/UpperWallRayCast"
@onready var mid_wall_ray_cast: RayCast2D = $"RayCast/MidWallRayCast"
@onready var lower_wall_ray_cast: RayCast2D = $"RayCast/LowerWallRayCast"

@onready var idle_state_timer: Timer = $"IdleStateTimer"
@onready var move_state_timer: Timer = $"MoveStateTimer"

func _ready() -> void:
	facing_direction = 1
	
	idle_state = get_state("FiniteStateMachine/FoxIdleState", "idle")
	move_state = get_state("FiniteStateMachine/FoxMoveState", "move")
	in_air_state = get_state("FiniteStateMachine/FoxInAirState", "in air")
	leap_state = get_state("FiniteStateMachine/FoxLeapState", "leap")
	transition_state(move_state)
	
func _physics_process(_delta: float) -> void:
	current_state.physics_update(_delta)
	
	move_and_slide()
	flip()

func flip() -> void:
	var front: bool = front_ground_ray_cast.is_colliding()
	var mid: bool = mid_wall_ray_cast.is_colliding()
	
	if is_on_floor() and (front != mid) and not front or mid:
		facing_direction *= -1
		scale.y = 1 if facing_direction == 1 else -1
		rotation_degrees = 0 if facing_direction == 1 else 180
