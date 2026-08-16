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
var horizontal_input: float
var vertical_input: bool
var vertical_input_released: bool

var vertical_input_buffer_timer: Timer
var vertical_input_released_buffer_timer: Timer

func _ready() -> void:
	idle_state = get_state("FiniteStateMachine/IdleState", "idle")
	move_state = get_state("FiniteStateMachine/MoveState", "move")
	in_air_state = get_state("FiniteStateMachine/InAirState", "in air")
	jump_state = get_state("FiniteStateMachine/JumpState", "jump")
	transition_state(idle_state)
	
	vertical_input_buffer_timer = get_node_or_null("VerticalInputBufferTimer")
	vertical_input_buffer_timer.timeout.connect(func() -> void: vertical_input = false)
	vertical_input_released_buffer_timer = get_node_or_null("VerticalInputReleasedBufferTimer")
	vertical_input_released_buffer_timer.timeout.connect(func() -> void: vertical_input_released = false)

func _physics_process(_delta: float) -> void:
	horizontal_input = Input.get_axis("ui_left", "ui_right")
	vertical_input_buffer(Input.is_action_just_pressed("ui_accept"))
	vertical_input_released_buffer(Input.is_action_just_released("ui_accept"))
	current_state.physics_update(_delta)
	
	move_and_slide()

func vertical_input_buffer(_vertical_input: bool) -> void:
	if not _vertical_input or vertical_input_buffer_timer.time_left != 0: return
	
	vertical_input = true
	vertical_input_buffer_timer.start()
	
func vertical_input_released_buffer(_vertical_input_released: bool) -> void:
	if not _vertical_input_released or vertical_input_released_buffer_timer.time_left != 0: return
	
	vertical_input_released = true
	vertical_input_released_buffer_timer.start()
