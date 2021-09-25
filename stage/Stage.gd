tool
class_name Stage extends YSort

const FLOODFILL_DELAY := 0.1

export var player_path := NodePath()
export var map_path := NodePath()

func tick_entities():
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
		{ "type": "splash", "at": var tile }:
			floodfill(tile)
	if entity != null:
		entity.apply_effect(self, effect)

func floodfill(tile: Vector2, delay := false):
	if delay:
		yield(get_tree().create_timer(FLOODFILL_DELAY), "timeout")
	var tile_type := get_map().get_tile_type(tile)
	if tile_type in Map.FILLABLE:
		var filled_type := Map.FILLABLE[tile_type] as String
		get_map().set_tile_type(tile, filled_type)
		for dir in Tile.DIRS:
			floodfill(tile + dir, true)
