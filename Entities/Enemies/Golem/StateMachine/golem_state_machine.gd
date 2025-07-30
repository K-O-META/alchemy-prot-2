extends Node2D

class_name GolemStateMachine

var current_state: GolemState
@onready var moving_state = $MovingState
@onready var preparing_state = $PreparingState
@onready var attacking_state = $AttackingState
@onready var golem: GolemTemplate

func _process(delta) -> void:
	if current_state:
		current_state.update(delta)

func change_state(new_state: GolemState) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func init(golem_t: GolemTemplate) -> void:
	golem = golem_t
	for state in get_children():
		state.golem = golem
	change_state(moving_state)
