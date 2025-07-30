class_name GolemTemplate extends CharacterBody2D

# STATE MACHINE
@onready var state_machine = $GolemStateMachine
@onready var texture_rect: TextureRect = $TextureRect
@onready var textures_array: Array[Texture2D] = [
	load("res://Entities/Enemies/Golem/golem_grey_moving.png"),
	load("res://Entities/Enemies/Golem/golem_grey_preparing.png"),
	load("res://Entities/Enemies/Golem/golem_grey_attacking.png")]

@onready var health_component: Node2D = $HealthComponent

func _ready():
	state_machine.init(self)

# TAKING DAMAGE
func take_damage(essence: Enums.Essences, damage: int) -> void:
	# Placeholder for damage logic
	if health_component:
		health_component.take_damage(essence, damage)
		print(health_component.max_health, health_component.current_health)
