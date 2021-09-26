class_name PoweredByEarth extends Property

export var mix_with: Script
export var wood_power_scn: PackedScene

func _handle_effect(_stage: Stage, _entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "gain_power", "power": var power }:
			if power is mix_with:
				effect.power = wood_power_scn.instance()
