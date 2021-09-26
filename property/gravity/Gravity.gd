class_name Gravity extends Property

export var falls_in_pits := false

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "move", "dir": var dir }:
			var tile := entity.tile + dir as Vector2
			var tile_type := stage.get_map().get_tile_type(tile)
			if tile_type in Map.SHALLOW_PIT_TILES:
				var block := stage.get_entity_at(tile)
				if	not falls_in_pits \
					and (block == null or not block.has_property(Steppable)):
						effect.canceled = true
		{ "type": "tick" }:
			if not entity.is_moving():
				var tile_type := stage.get_map().get_tile_type(entity.tile)
				if tile_type in Map.DEEP_PIT_TILES:
					# TODO dying nimation
					entity.queue_free()
				elif tile_type in Map.SHALLOW_PIT_TILES and falls_in_pits:
					entity.sunk = true
				else:
					entity.sunk = false
