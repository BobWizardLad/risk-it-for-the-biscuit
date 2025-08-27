class_name ShadowReveal
extends Node2D

var raycasts: Array = []

func _ready():
	for child in get_children():
		if child is RayCast2D:
			raycasts.append(child)

func _process(delta):
	for ray in raycasts:
		if ray.is_colliding():
			var collider = ray.get_collider()
			var collision_point = ray.get_collision_point()
			_on_ray_collision(ray, collider, collision_point)

func _on_ray_collision(ray, collider, collision_point):
	if collider is TileMapLayer:
		var tile_layer: TileMapLayer = collider
		if tile_layer.name == "Shadows":
			# Offset the collision point slightly towards the ray's origin to avoid edge ambiguity
			var direction = (collision_point - ray.global_position).normalized()
			var adjusted_collision_point = collision_point + direction * 0.1
			var local_collision = tile_layer.to_local(adjusted_collision_point)
			var tile_pos: Vector2 = tile_layer.local_to_map(local_collision)
			tile_layer.erase_cell(tile_pos)
