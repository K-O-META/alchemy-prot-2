extends GolemState
class_name AttackingState

var attack_timer := 0.5

func enter():
	golem.texture_rect.texture = golem.textures_array[2]
	attack_timer = 0.5

func update(delta):
	attack_timer -= delta
	if attack_timer <= 0:
		get_parent().change_state(get_parent().moving_state)

func exit():
	pass
