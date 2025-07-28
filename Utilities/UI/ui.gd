extends Control

@onready var potion_icons: Array = []
@export var player: Player
@onready var health_bar: Control = $HealthBar
@onready var dash_bar: Control = $DashBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_potion()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# HP TRACKER
	if player:
		health_bar.get_node("HPBar").scale.x = float(player.health_component.current_health) / float(player.health_component.max_health)
	else:
		health_bar.get_node("HPBar").scale.x = 0
	# DASH CD TRACKER
	if player:
		if not player.dash_timer.is_stopped():
			dash_bar.visible = true
			dash_bar.get_node("DashBar").scale.x = player.dash_timer.time_left / player.dash_timer.wait_time
		else:
			dash_bar.visible = false
		dash_bar.get_node("DashBar").color = Color(float(player.dash_counter)/player.dashes_limit, 1.0 - (float(player.dash_counter)/player.dashes_limit), 0.0)

func change_potion(for_next: bool = true) -> void:
	var potions_indexes: Array = [0,0,0]
	if for_next:
		GameManager.potions_counter += 1
	else:
		GameManager.potions_counter -= 1
	var potions_num = GameManager.inventory_potions.size()
	potions_indexes = [(GameManager.potions_counter-1) % potions_num, GameManager.potions_counter % potions_num, (GameManager.potions_counter+1) % potions_num]
	
	$"PotionSelectionContainer/PreviousPotion".texture = GameManager.inventory_potions[potions_indexes[0]].potion_texture
	$"PotionSelectionContainer/ActualPotion".texture = GameManager.inventory_potions[potions_indexes[1]].potion_texture
	$"PotionSelectionContainer/NextPotion".texture = GameManager.inventory_potions[potions_indexes[2]].potion_texture
