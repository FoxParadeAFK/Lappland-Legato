class_name Player extends CharacterBody2D

var current_state: State
var idle_state: IdleState
var move_state: MoveState
var in_air_state: InAirState
var jump_state: JumpState
func transition_state(_transitioning_state: State) -> void:
	if current_state != null: current_state.exit()
	
	current_state = _transitioning_state
	print("Time: %5s State: %s" % [Time.get_ticks_msec(), current_state.animation_name])
	animation_tree.set("parameters/Transition/transition_request", current_state.animation_name)
	current_state.enter()

func get_state(_state_path: NodePath, _animation_name: String) -> State:
	var state: State = get_node_or_null(_state_path)
	if state != null: state.engage(self, _animation_name)
	
	return state
	
enum {HORIZONTAL_VELOCITY = 80, VERTICAL_VELOCITY = 120, GRAVITY = 650}
enum {JUMP_COUNT =  1}
var jump_count: int
var horizontal_input: float
var vertical_input: bool
var vertical_input_held: bool

var animation_tree: AnimationTree
var vertical_input_buffer_timer: Timer
var coyote_timer: Timer

var facing_direction: int

func _ready() -> void:
	facing_direction = 1
	animation_tree = get_node_or_null("AnimationTree")
	
	idle_state = get_state("FiniteStateMachine/IdleState", "idle")
	move_state = get_state("FiniteStateMachine/MoveState", "move")
	in_air_state = get_state("FiniteStateMachine/InAirState", "in air")
	jump_state = get_state("FiniteStateMachine/JumpState", "jump")
	transition_state(idle_state)
	
	vertical_input_buffer_timer = get_node_or_null("VerticalInputBufferTimer")
	vertical_input_buffer_timer.timeout.connect(func() -> void: vertical_input = false)
	coyote_timer = get_node_or_null("CoyoteTimer")
	coyote_timer.timeout.connect(func() -> void: jump_count -= 1)
	

func _physics_process(_delta: float) -> void:
	horizontal_input = Input.get_axis("ui_left", "ui_right")
	vertical_input = input_buffer(Input.is_action_just_pressed("ui_accept"), vertical_input_buffer_timer)
	vertical_input_held = Input.is_action_pressed("ui_accept")
	current_state.physics_update(_delta)
	
	flip()
	move_and_slide()

func input_buffer(_input: bool, _timer: Timer) -> bool:
	if not _input and _timer.time_left == 0: return false
	if _timer.time_left != 0: return true
	
	_timer.start()
	return true

func reset_jump_count() -> void:
	jump_count = JUMP_COUNT

func should_jump() -> bool:
	return jump_count > 0
	
func flip() -> void:
	if horizontal_input != 0 and horizontal_input != facing_direction:
		facing_direction *= -1
		scale.y = 1 if facing_direction == 1 else -1
		rotation_degrees = 0 if facing_direction == 1 else 180
