class_name Absorbable extends Property

export var power_property: Script

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "collide", "with": var other, .. }:
			if other.is_in_group("player"):
				effect.blocked = false
				stage.apply_effect(other, {
					type = "gain_power",
					power = power_property
				})
				entity.queue_free()
