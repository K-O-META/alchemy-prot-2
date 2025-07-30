class_name BarsComponent extends Control

@onready var vbox_container: VBoxContainer = $VBoxContainer
@onready var health_bar_scene := load("res://Entities/Components/BarsComponent/health_bar.tscn")
@onready var dash_bar_scene := load("res://Entities/Components/BarsComponent/dash_bar.tscn")

var health_bar: Control

func _ready() -> void:
	if get_parent() is not Player:
		health_bar = add_bar(Enums.Bars.HEALTH)

func add_bar(bar_type: Enums.Bars) -> Control:
	var new_bar
	match bar_type:
		Enums.Bars.HEALTH:
			new_bar = health_bar_scene.instantiate()
		Enums.Bars.DASH:
			new_bar = dash_bar_scene.instantiate()
		_:
			print("ERROR: WRONG BAR_TYPE")
			return
	vbox_container.add_child(new_bar)
	return new_bar

func remove_bar() -> void:
	pass
