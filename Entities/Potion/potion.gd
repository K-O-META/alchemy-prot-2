class_name Potion extends Node2D

var essence: Enums.Essences
var potion_texture: Texture2D
var explosion_texture: Texture2D




func set_essence(essence_t: Enums.Essences) -> void:
	essence = essence_t
	match essence:
		Enums.Essences.PHYSICAL:
			pass
		Enums.Essences.FIRE:
			potion_texture = load("res://Entities/Potion/PotionIcons/PotionFire.png")
			explosion_texture = load("res://Entities/Potion/ExplosionIcons/ExplosionFire.png")
		Enums.Essences.ICE:
			potion_texture = load("res://Entities/Potion/PotionIcons/PotionIce.png")
			explosion_texture = load("res://Entities/Potion/ExplosionIcons/ExplosionIce.png")
		_:
			push_error("Nieznana esencja: " + str(essence))
