tool
class_name Entity extends Node2D

const GROUP := "entity"
const MOVING_THRESHOLD := 10*10

export var tile := Vector2.ZERO setget set_tile
export var sprite_path := NodePath()
export var SMOOTH := 6

var sunk := false

var dirty := false
var target_pos: Vector2

func set_tile(value: Vector2):
	tile = value
	dirty = true

func _process_entity(map: TileMap, delta: float):
	if Engine.editor_hint:
		update_tile_and_snap_to_grid(map)
	else:
		animate_movement(map, delta)

func update_tile_and_snap_to_grid(map: TileMap):
	tile = map.world_to_map(position).floor()
	position = map.map_to_world(tile) + map.cell_size / 2

func is_moving() -> bool:
	return 	target_pos.distance_squared_to(position) > MOVING_THRESHOLD \
		or	dirty

func animate_movement(map: TileMap, delta: float):
	dirty = false
	target_pos = map.map_to_world(tile) + map.cell_size / 2
	position += (target_pos - position) * SMOOTH * delta
	
	var sprite := get_node_or_null(sprite_path) as Node2D
	if sprite != null:
		if sunk:
			sprite.position.y = 16
			z_index = 0
		else:
			sprite.position.y = 0
			z_index = 1

func apply_effect(stage: Node, effect: Dictionary):
	var children := get_children()
	children.invert()
	for child in children:
		if child.has_method("_handle_effect"):
			if not effect.get("cancelled", false):
				child._handle_effect(stage, self, effect)

func has_property(script: Script) -> bool:
	for child in get_children():
		if child is script:
			return true
	return false
