extends GolemState
class_name MovingState

var move_timer := 0.0

func enter():
	golem.texture_rect.texture = golem.textures_array[0]
	move_timer = 2.0

func update(delta):
	var angle = randf_range(0.0, TAU)
	var random_variation = Vector2(cos(angle), sin(angle)) * randi_range(0, 100)
	golem.position += random_variation * delta

	move_timer -= delta
	if move_timer <= 0:
		get_parent().change_state(get_parent().preparing_state)

func exit():
	pass
