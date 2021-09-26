class_name Map extends TileMap

const GROUND_TILES = ["grass"]
const SHALLOW_PIT_TILES = ["shallow", "shallow_pit"]
const DEEP_PIT_TILES = ["void", "deep_pit"]
const WATER_TILES = ["water", "water_border"]

const FILLABLE := {
	"shallow": "water",
	"shallow_pit": "water_border"
}

func set_tile_type(tile: Vector2, type: String):
	var cell := tile_set.find_tile_by_name(type)
	set_cellv(tile, cell)

func get_tile_type(tile: Vector2) -> String:
	var cell := get_cellv(tile)
	return tile_set.tile_get_name(cell) if cell >= 0 else "unknown"
