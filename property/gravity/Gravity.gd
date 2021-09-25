class_name Gravity extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "move", "dir": var dir }:
			var tile := entity.tile + dir as Vector2
			var tile_type := stage.get_map().get_tile_type(tile)
			if tile_type in Map.SHALLOW_PIT_TILES:
				effect.canceled = true
		{ "type": "tick" }:
			if not entity.moving:
				var tile_type := stage.get_map().get_tile_type(entity.tile)
				if tile_type in Map.DEEP_PIT_TILES:
					# TODO dying nimation
					entity.queue_free()
