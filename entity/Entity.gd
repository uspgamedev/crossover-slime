tool
class_name Entity extends Node2D

const GROUP := "entity"
const MOVING_THRESHOLD := 10*10

export var tile := Vector2.ZERO
export var SMOOTH := 6

var moving := false

func _process_entity(map: TileMap, delta: float):
	if Engine.editor_hint:
		update_tile_and_snap_to_grid(map)
	else:
		animate_movement(map, delta)

func update_tile_and_snap_to_grid(map: TileMap):
	tile = map.world_to_map(position).floor()
	position = map.map_to_world(tile) + map.cell_size / 2

func animate_movement(map: TileMap, delta: float):
	var target_pos := map.map_to_world(tile) + map.cell_size / 2
	position += (target_pos - position) * SMOOTH * delta
	if target_pos.distance_squared_to(position) > MOVING_THRESHOLD:
		moving = true
	else:
		moving = false

func apply_effect(stage: Node, effect: Dictionary):
	var children := get_children()
	children.invert()
	for child in children:
		if child.has_method("_handle_effect"):
			if not effect.get("canceled", false):
				child._handle_effect(stage, self, effect)

func has_property(script: Script) -> bool:
	for child in get_children():
		if child is script:
			return true
	return false
