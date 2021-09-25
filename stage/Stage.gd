tool
class_name Stage extends YSort

export var player_path := NodePath()
export var map_path := NodePath()

func _physics_process(_delta):
	if not Engine.editor_hint:
		for node in get_children():
			if node is Entity:
				apply_effect(node, { type = "tick" })

func _process(delta):
	for node in get_children():
		if node is Entity:
			node._process_entity($Map, delta)

func get_player() -> Entity:
	return get_node_or_null(player_path) as Entity

func get_map() -> Map:
	return get_node_or_null(map_path) as Map

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
