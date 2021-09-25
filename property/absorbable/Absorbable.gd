class_name Absorbable extends Property

func _handle_effect(_stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "collide", "with": var other, .. }:
			if other.is_in_group("player"):
				effect.blocked = false
				# TODO
				entity.queue_free()
