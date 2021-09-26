extends Property

export var animation_path := NodePath()

func _handle_effect(_stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "die" }:
			var anim := get_node(animation_path) as AnimationPlayer
			for child in entity.get_children():
				if child.get_script() in [Movable, FacingDirection]:
					child.queue_free()
			anim.play("ripperino")
			yield(anim, "animation_finished")
			entity.queue_free()
