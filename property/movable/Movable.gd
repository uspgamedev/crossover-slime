class_name Movable extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "move", "dir": var dir }:
			var new_tile := entity.tile + dir as Vector2
			var block := stage.get_entity_at(new_tile)
			if block != null:
				var collide_effect := {
					type = "collide",
					with = entity,
					blocked = true
				}
				stage.apply_effect(block, collide_effect)
				if collide_effect.blocked:
					return
			entity.tile = new_tile
