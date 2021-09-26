class_name PoweredByWater extends Powered

export var mix_with_fire: Script
export var air_power_scn: PackedScene

export var mix_with_earth: Script
export var wood_power_scn: PackedScene

export var mix_with_wind: Script
export var cloud_power_scn: PackedScene

export var squirt_scn: PackedScene

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "use_power" }:
			$AudioStreamPlayer.play()
			var check_dir := {
				type = "check_dir", dir = Vector2.DOWN
			}
			stage.apply_effect(entity, check_dir)
			var dir := check_dir.dir as Vector2
			var map := stage.get_map()
			var target_tile := entity.tile + dir
			var target_pos := map.map_to_world(entity.tile) as Vector2 \
							+ map.cell_size as Vector2 / 2.0
			var squirt := squirt_scn.instance() as Node2D
			squirt.position = target_pos + 0.3 * dir * map.cell_size
			squirt.rotation = dir.angle()
			stage.add_child(squirt)
			yield(get_tree().create_timer(0.5), "timeout")
			stage.apply_effect(null, {
				type = "splash",
				at = target_tile
			})
		{ "type": "gain_power", "power": var power }:
			if power is mix_with_fire:
				effect.power = air_power_scn.instance()
			elif power is mix_with_earth:
				effect.power = wood_power_scn.instance()
			elif power is mix_with_wind:
				effect.power = cloud_power_scn.instance()
