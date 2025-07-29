class_name HealthComponent extends Node2D

@export var max_health: int = 100
var current_health: int = 100
@export var health_bar: Control

func _ready() -> void:
	var parent = get_parent()
	if parent is Player:
		health_bar = parent.health_bar

func take_damage(essence: Enums.Essences, amount: int) -> void:
	if has_node("ReactionComponent"):
		amount = $ReactionComponent.reaction_for_damage(essence, amount)
	current_health -= amount
	if current_health <= 0:
		get_parent().queue_free()
	health_bar.update_bar(current_health)
