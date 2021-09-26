class_name LaserBeam extends Property

var dir = Vector2.ZERO
var is_active = true

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "tick" }:
			var entity_type := stage.get_entity_at(entity.tile)
			if entity_type.has_property(BlockLaser):
				
				stage.apply_effect(entity, {
					type = "block",
					is_blocked = true
				})
			else:
				stage.apply_effect(entity, {
					type = "block",
					is_blocked = false
				})
		{ "type": "block", "is_blocked": var value }:
			entity.visible = value
			is_active = value
			toggle_neighbors(stage, entity, value)
		{ "type": "set_direction", "dir": var _dir }:
			dir = _dir


func toggle_neighbors(_stage, _entity, _is_blocked):
	var target_entity = _stage.get_entity_at(_entity.tile + dir)
	if target_entity and target_entity.get_class() == _entity.get_class():
		_stage.apply_effect(target_entity, {
			type = "block",
			is_blocked = _is_blocked
		})
