class_name Flammable extends Property

func _handle_effect(_stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "burn" }:
			entity.queue_free()
