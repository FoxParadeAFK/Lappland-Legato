class_name Player extends CharacterBody2D

var current_state: State
var idle_state: IdleState
var move_state: MoveState
var in_air_state: InAirState
var jump_state: JumpState
func transition_state(_transitioning_state: State) -> void:
	if current_state != null: current_state.exit()
	
	print("Time: %5s State: %s" % [Time.get_ticks_msec(), _transitioning_state.animation_name])
	current_state = _transitioning_state
	current_state.enter()

func get_state(_state_path: NodePath, _animation_name: String) -> State:
	var state: State = get_node_or_null(_state_path)
	if state != null: state.engage(self, _animation_name)
	
	return state
	
enum {HORIZONTAL_VELOCITY = 100, VERTICAL_VELOCITY = 140, GRAVITY = 650}
enum {JUMP_COUNT =  1}
var jump_count: int
var horizontal_input: float
var vertical_input: bool
var vertical_input_held: bool

var vertical_input_buffer_timer: Timer
var coyote_timer: Timer

func _ready() -> void:
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
