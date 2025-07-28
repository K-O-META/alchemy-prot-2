extends Node2D


var inventory_potions: Array[Potion] = []
var potions_counter: int = 0

func _ready() -> void:
	_load_default_potions()

func _load_default_potions() -> void:
	if inventory_potions.is_empty():
		for essence in Enums.Essences.values():
			var potion = Potion.new()
			potion.set_essence(essence)
			inventory_potions.append(potion)
		
