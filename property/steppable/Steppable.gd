class_name Steppable extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "collide", .. }:
			var tile_type := stage.get_map().get_tile_type(entity.tile)
			if		tile_type in Map.SHALLOW_PIT_TILES \
				or	tile_type in Map.WATER_TILES:
					effect.blocked = false
