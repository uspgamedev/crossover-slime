class_name Map extends TileMap

const SHALLOW_PIT_TILES = ["shallow", "shallow_pit"]
const DEEP_PIT_TILES = ["void", "deep_pit"]

func get_tile_type(tile: Vector2) -> String:
	var cell := get_cellv(tile)
	return tile_set.tile_get_name(cell)
