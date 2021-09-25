class_name Goal extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "collide", "with": var other, .. }:
			if other.has_property(Fagocitosis):
				effect.blocked = false
		{ "type": "tick" }:
			for other in stage.get_all_entities_at(entity.tile):
				if other != entity:
					if other is Entity and other.has_property(Fagocitosis):
						stage.win()
