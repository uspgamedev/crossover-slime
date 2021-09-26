class_name PoweredByLightning extends Property

export var zap_scn: PackedScene

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "use_power" }:
			var check_dir := {
				type = "check_dir", dir = Vector2.DOWN
			}
			stage.apply_effect(entity, check_dir)
			var dir := check_dir.dir as Vector2
			var map := stage.get_map()
			var target_tile := entity.tile + dir
			while 	map.get_cellv(target_tile) >= 0 \
				and	stage.get_entity_at(target_tile) == null:
					target_tile += dir
#			var target_pos := map.map_to_world(target_tile) as Vector2 \
#							+ map.cell_size as Vector2 / 2.0
#			var zap := zap_scn.instance() as Node2D
#			zap.position = target_pos
#			stage.add_child(zap)
			var target_entity := stage.get_entity_at(target_tile)
			if target_entity != null:
				stage.apply_effect(target_entity, {
					type = "burn"
				})
#		{ "type": "gain_power", "power": var power }:
#			if power is mix_with:
#				effect.power = air_power_scn.instance()

