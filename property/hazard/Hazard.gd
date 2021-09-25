class_name Hazard extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "collide", "with": var other, .. }:
			if other.has_property(PoweredByEarth):
				effect.blocked = false
			else:
				print_debug("ouchie!")
