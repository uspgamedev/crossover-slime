class_name Flammable extends Property

# time it takes to spread flames
export var flammability := 1.0

# time until object completely burns
export var fuel := 2.0
onready var bonfire_scn = preload("res://vfx/Bonfire.tscn")
var burning = false

const DIRS := [
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2.UP,
	Vector2.DOWN,
]

func _handle_effect(_stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "burn" }:
			if not burning:
				burning = true
				var map := _stage.get_map()
				var bonfire := bonfire_scn.instance() as Node2D
				if fuel > 0:
					bonfire.duration = flammability + fuel
				else:
					bonfire.duration = -1
				bonfire.global_position = 	map.map_to_world(entity.tile) \
											+ map.cell_size as Vector2 / 2.0
				_stage.add_child(bonfire)
				yield(get_tree().create_timer(flammability), "timeout")
				for dir in DIRS:
					var target_entity = _stage.get_entity_at(entity.tile + dir)
					if target_entity != null:
						_stage.apply_effect(target_entity, {
							type = "burn"
						})
				if fuel > 0:
					yield(get_tree().create_timer(fuel), "timeout")
					entity.queue_free()
