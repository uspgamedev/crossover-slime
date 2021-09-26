class_name Absorbable extends Property

export var power_property_scn: PackedScene

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "collide", "with": var other, .. }:
			if other.has_property(Fagocitosis):
				effect.blocked = false
				var power: Property = null
				if power_property_scn != null:
					power = power_property_scn.instance() 
				stage.apply_effect(other, {
					type = "gain_power",
					power = power
				})
				entity.queue_free()
