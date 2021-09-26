class_name Hazard extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "tick" }:
			if not entity.is_moving():
				var tile_type := stage.get_map().get_tile_type(entity.tile)
				if tile_type in Map.SPIKE_TILES:
					if not entity.has_property(PoweredByEarth):
						stage.apply_effect(entity, { type = "die" } )
					else:
						pass
						# TODO effect against spikes
				if tile_type in Map.WATER_TILES:
					if entity.has_property(PoweredByEarth):
						stage.apply_effect(entity, { type = "die" } )
					elif entity.has_property(PoweredByFire):
						stage.apply_effect(entity, { type = "die" } )
						
#				var entity_type := stage.get_entity_at(entity.tile)
				if entity.has_property(LaserBeam):
					stage.apply_effect(entity, { type = "die" } )
