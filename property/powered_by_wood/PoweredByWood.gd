extends Powered

export var trunk_scn: PackedScene

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
			# Check if tile is empty
			if stage.get_entity_at(target_tile) != null:
				return
			# Check if tile is grass
			var tile_type := map.get_tile_type(target_tile)
			if not tile_type in Map.GROUND_TILES:
				return
			var trunk := trunk_scn.instance() as Entity
			trunk.tile = target_tile
			trunk.position = map.map_to_world(target_tile) + map.cell_size / 2
			stage.add_child(trunk)
