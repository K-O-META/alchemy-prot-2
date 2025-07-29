class_name BarClass extends Node

@onready var background_bar: ColorRect = $BackgroundBar
@onready var current_bar: ColorRect = get_children()[2] # CURRENT BAR ALWAYS 3RD!!!!!

var max_value: float = 100.0
var current_value: float = 100.0

func init(max_value_t: float = 100.0, current_value_t: float = 100.0) -> void:
	max_value = max_value_t
	current_value = current_value_t

func update_bar(current_value_t: float = 100.0) -> void:
	if current_value_t > max_value:
		current_value = max_value
	else:
		current_value = current_value_t
	current_bar.scale.x = current_value / max_value
