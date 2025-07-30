extends GolemState
class_name PreparingState

var prep_timer := 1.0

func enter():
	golem.texture_rect.texture = golem.textures_array[1]
	prep_timer = 1.0

func update(delta):
	prep_timer -= delta
	if prep_timer <= 0:
		get_parent().change_state(get_parent().attacking_state)

func exit():
	pass
