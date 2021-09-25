class_name Stage extends YSort

export var player_path := NodePath()

func _process(delta):
	for node in get_tree().get_nodes_in_group(Entity.GROUP):
		if node is Entity:
			node._process_entity($Map, delta)

func get_player() -> Entity:
	return get_node_or_null(player_path) as Entity

func get_entity_at(tile: Vector2) -> Entity:
	for node in get_tree().get_nodes_in_group(Entity.GROUP):
		if node is Entity:
			if node.tile == tile:
				return node
	return null

func apply_effect(entity: Entity, effect: Dictionary):
	match effect:
		_:
			pass
	entity.apply_effect(self, effect)
