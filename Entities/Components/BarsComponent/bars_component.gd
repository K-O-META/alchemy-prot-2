class_name BarsComponent extends Control

@onready var vbox_container: VBoxContainer = $VBoxContainer
@onready var health_bar := load("res://Entities/Components/BarsComponent/health_bar.tscn")
@onready var dash_bar := load("res://Entities/Components/BarsComponent/dash_bar.tscn")

"""func add_bar(bar_type: Enums.BARS) -> void:
	var new_bar
	match bar_type:
		Enums.BARS.HEALTH:
			new_bar = health_bar.instantiate()
		Enums.BARS.DASH:
			new_bar = dash_bar.instantiate()
		_:
			print("ERROR: WRONG BAR_TYPE")
			return
	vbox_container.add_child(new_bar)"""

func remove_bar() -> void:
	pass
