class_name Entity extends Node2D

const GROUP := "entity"

export var tile := Vector2.ZERO
export var SMOOTH := 5

func _process_entity(map: TileMap, delta: float):
	var target_pos := map.map_to_world(tile) + map.cell_size / 2
	position += (target_pos - position) * SMOOTH * delta
