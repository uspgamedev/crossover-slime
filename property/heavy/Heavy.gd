class_name Heavy extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "tick" }:
			if not entity.is_moving():
				var tile_type := stage.get_map().get_tile_type(entity.tile)
				if tile_type in Map.WATER_TILES:
					entity.sunk = true
