class_name PotionToThrow extends Area2D

var is_alive: bool = true
var lifespan_limit: float = 1.0
var lifespan: float = 0.0
var start_position: Vector2
var destination: Vector2
var potion: Potion



func _process(delta: float) -> void:
	lifespan += delta
	if lifespan <= lifespan_limit:
		position = lerp(start_position, destination, (lifespan/lifespan_limit))
	else:
		if is_alive:
			is_alive = false
			explode()


func init_potion_to_throw(position_t: Vector2, destination_t: Vector2, potion_t: Potion) -> void:
	start_position = position_t
	position = position_t
	destination = destination_t
	potion = potion_t
	
	update_graphics()


func update_graphics() -> void:
	$PotionTexture.texture = potion.potion_texture
	$Explosion/ExplosionTexture.texture = potion.explosion_texture


func explode() -> void:
	$Explosion.visible = true
	var bodies = $Explosion.get_overlapping_bodies()
	for body in bodies:
		if body.has_method("take_damage"):
			body.take_damage(potion.essence, 4)
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
