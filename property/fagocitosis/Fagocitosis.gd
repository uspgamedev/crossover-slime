class_name Fagocitosis extends Property

onready var current_power: Property

func _handle_effect(_stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "gain_power", "power": var power }:
			if current_power != null:
				current_power.free()
			current_power = power
			if power != null:
				entity.add_child(power)
