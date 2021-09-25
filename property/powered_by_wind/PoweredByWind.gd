extends Property

export var gust_scn: PackedScene

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
			var target_pos := map.map_to_world(target_tile) as Vector2 \
							+ map.cell_size as Vector2 / 2.0
			var gust := gust_scn.instance() as Node2D
			gust.position = target_pos
			stage.add_child(gust)
			var target_entity := stage.get_entity_at(target_tile)
			if target_entity != null:
				stage.apply_effect(target_entity, {
					type = "move", dir = dir
				})
