class_name PoweredByFire extends Powered

export var mix_with_water: Script
export var air_power_scn: PackedScene

export var mix_with_air: Script
export var lightning_power_scn: PackedScene

export var flames_scn: PackedScene

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "use_power" }:
			$AudioStreamPlayer2D.play()
			var check_dir := {
				type = "check_dir", dir = Vector2.DOWN
			}
			stage.apply_effect(entity, check_dir)
			var dir := check_dir.dir as Vector2
			var map := stage.get_map()
			var target_tile := entity.tile + dir
			var target_pos := map.map_to_world(target_tile) as Vector2 \
							+ map.cell_size as Vector2 / 2.0
			var flames := flames_scn.instance() as Node2D
			flames.position = target_pos
			stage.add_child(flames)
			var target_entity := stage.get_entity_at(target_tile)
			if target_entity != null:
				stage.apply_effect(target_entity, {
					type = "burn"
				})
		{ "type": "gain_power", "power": var power }:
			if power is mix_with_water:
				effect.power = air_power_scn.instance()
			if power is mix_with_air:
				effect.power = lightning_power_scn.instance()
