class_name Fagocitosis extends Property

export var default_sprite: SpriteFrames

onready var current_power: Powered

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "gain_power", "power": var power }:
			if current_power != null:
				current_power.free()
			current_power = power
			var sprite := entity.get_sprite() as AnimatedSprite
			if power != null:
				entity.add_child(power)
				sprite.frames = power.appearance
				sprite.modulate = power.color_override
				stage.update_power_name(power.power_name)
				print_debug(power.power_name)
				DJ.play_with_cross_fade(power.power_name, 0.2, 0.8)
				DJ.play_sfx(power.power_name)
			else:
				sprite.frames = default_sprite
				sprite.modulate = Color.white
				stage.update_power_name("NONE")
				DJ.play_with_cross_fade("NONE", 0.2, 0.8)
				DJ.play_sfx("NONE")
