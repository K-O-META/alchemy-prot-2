class_name HealthComponent extends Node2D

@export var max_health: int = 100
var current_health: int = 100
@onready var health_bar: Control = $BarsComponent/VBoxContainer/HealthBar

"""func _ready() -> void:
	if get_parent() is Player:
		health_bar.visible = false"""

func take_damage(essence: Enums.Essences, amount: int) -> void:
	if has_node("ReactionComponent"):
		amount = $ReactionComponent.reaction_for_damage(essence, amount)
	current_health -= amount
	if current_health <= 0:
		get_parent().queue_free()
	health_bar.get_node("HPBar").scale.x = float(current_health) / max_health
