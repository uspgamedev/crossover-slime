class_name LaserCaster extends Property

export(String, "Right", "Left", "Up", "Down") var dir

onready var beam_scn = preload("res://entity/laser_beam/LaserBeam.tscn")

const DIRS = {
	"Right": Vector2.RIGHT,
	"Left": Vector2.LEFT,
	"Up": Vector2.UP,
	"Down": Vector2.DOWN,
}

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "tick" }:
			var map := stage.get_map()
			var target_tile := entity.tile + DIRS[dir] as Vector2
			while map.get_cellv(target_tile) >= 0:
				var block := stage.get_entity_at(target_tile)
				if block != null:
					if 		block.has_property(Fagocitosis) \
						and not block.is_moving():
							block.queue_free()
					if not block.sunk:
						break
				if map.get_tile_type(target_tile) in Map.WALL_TILES:
					break
				target_tile += DIRS[dir] as Vector2
			var target_pos := map.map_to_world(target_tile) as Vector2 \
							+ map.cell_size as Vector2 / 2.0
			var offset := target_pos - entity.position
			offset -= DIRS[dir] as Vector2 * map.cell_size.x / 2
			$Laser.points[0] = DIRS[dir] as Vector2 * map.cell_size.x / 2
			$Laser.points[1] = offset
