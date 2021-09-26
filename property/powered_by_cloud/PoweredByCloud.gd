class_name PoweredByCloud extends Property

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "use_power" }:
			var check_dir := {
				type = "check_dir", dir = Vector2.DOWN
			}
			stage.apply_effect(entity, check_dir)
			var dir := check_dir.dir as Vector2
			var map := stage.get_map()
			var dist := 0
			var target_tile := entity.tile
			while dist < 2:
				target_tile += dir
				if		map.get_cellv(target_tile) >= 0 \
					and	stage.get_entity_at(target_tile) == null:
						dist += 1
				else:
					break
			if dist > 0:
				stage.apply_effect(entity, {
					type = "move", dir = dir * dist
				})
