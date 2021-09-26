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
			var check_dir := {
				type = "check_dir", dir = Vector2.DOWN
			}
			stage.apply_effect(entity, check_dir)
			var dir := check_dir.dir as Vector2
#			var map := stage.get_map()
			var target_tile := entity.tile + dir
			# TODO: squirt vfx
#			var target_pos := map.map_to_world(target_tile) as Vector2 \
#							+ map.cell_size as Vector2 / 2.0
#			var squirt := squirt_scn.instance() as Node2D
#			squirt.position = target_pos
#			stage.add_child(squirt)
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
