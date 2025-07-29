class_name Player extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var ui: Control = get_parent().get_node("CanvasLayer/UI")
@onready var dash_timer: Timer = $DashTimer
@export var health_bar: Control

@export var move_speed: float = 200.0
@export var dash_distance: float = 100
@export var dashes_limit: int = 2
@export var one_dash_time: float = 0.1
var is_dashing: bool = false
var dash_counter: int = 0
var is_shooting: bool = false
var actual_shooting_range: float = 0.0
@export var range_limit: float = 6.0
@export var shooting_speed:float = 6.0
@onready var potion_to_throw_scene := load("res://Entities/Potion/potion_to_throw.tscn")


func _process(delta: float) -> void:
	# MOVING
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
	velocity = input_vector * move_speed
	move_and_slide()
	
	if Input.is_action_just_pressed("dash"):
		dash(input_vector)
	
	#SHOOTING
	aiming()
	if Input.is_action_just_pressed("potion_switch_left"):
		ui.change_potion(false)
	if Input.is_action_just_pressed("potion_switch_right"):
		ui.change_potion()
	if Input.is_action_just_pressed("shooting"):
		is_shooting = true
	if is_shooting:
		start_shooting(delta)

# DASHING
func dash(input_vector: Vector2) -> void:
	if dash_timer.is_stopped():
		dash_timer.start()
	if dash_counter < dashes_limit and not is_dashing:
		dash_counter += 1
		var direction
		# DASHING DIRECTION
		if input_vector:
			direction = input_vector * dash_distance
		else:
			direction = (get_global_mouse_position() - global_position).normalized() * dash_distance
		var tween: Tween = create_tween()
		is_dashing = true
		tween.tween_property(self, "position", position+direction, one_dash_time)#.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await tween.finished
		is_dashing = false

func _on_dash_timer_timeout() -> void:
	dash_counter = 0

# SHOOTING
func aiming() -> void:
	var mouse_pos = get_global_mouse_position()
	var player_pos = global_position
	var direction = mouse_pos - player_pos
	var angle = direction.angle() + PI/2
	$AimingArrow.rotation = angle

func start_shooting(delta: float) -> void:
	actual_shooting_range += delta * shooting_speed
	if actual_shooting_range > range_limit:
		actual_shooting_range = range_limit
	$AimingArrow/ForceBar.position.y = -74 + (actual_shooting_range * 37)
	if Input.is_action_just_released("shooting"):
		is_shooting = false
		var direction = (get_global_mouse_position() - global_position).normalized() * 100
		var destination = global_position + (0.36 * direction) + (actual_shooting_range * $AimingArrow/ForceBar.size.y/100) * direction
		shoot(destination)
		actual_shooting_range = 0.0
	$AimingArrow/ForceBar.scale.y = actual_shooting_range

func shoot(destination: Vector2) -> void:
	pass
	var potion_to_throw = potion_to_throw_scene.instantiate()
	get_parent().add_child(potion_to_throw)
	# ADVANCED MATH, BECOUSE WE WILL MAKE IT WITH INVENTORY SYSTEM LATER
	var current_potion: Potion = GameManager.inventory_potions[GameManager.potions_counter % GameManager.inventory_potions.size()]
	potion_to_throw.init_potion_to_throw(position, destination, current_potion)


# TAKING DAMAGE
func take_damage(essence: Enums.Essences, damage: int) -> void:
	# Placeholder for damage logic
	print("Player took damage: ")
	placeholder_blink_red()
	if health_component:
		health_component.take_damage(essence, damage)

func placeholder_blink_red() -> void:
	# Placeholder for blink red logic
	$PlayerColor.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.1).timeout
	$PlayerColor.modulate = Color(1, 1, 1)
