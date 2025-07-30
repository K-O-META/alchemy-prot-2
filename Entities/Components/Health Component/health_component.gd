class_name HealthComponent extends Node2D

@export var max_health: int = 100
var current_health: int
var health_bar: Control
@export var bars_component: BarsComponent

func _ready() -> void:	
	if get_parent() is Player:
		health_bar = get_parent().health_bar
	else:
		health_bar = bars_component.health_bar
	
	current_health = max_health
	health_bar.init(max_health, current_health)

func take_damage(essence: Enums.Essences, amount: int) -> void:
	if has_node("ReactionComponent"):
		amount = $ReactionComponent.reaction_for_damage(essence, amount)
	current_health -= amount
	if current_health <= 0:
		get_parent().queue_free()
	health_bar.update_bar(current_health)
