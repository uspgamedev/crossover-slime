class_name LaserCaster extends Property

export(String, "Right", "Left", "Up", "Down") var dir

onready var beam_scn = preload("res://entity/laser_beam/LaserBeam.tscn")

var once = true

const DIRS = {
	"Right": Vector2.RIGHT,
	"Left": Vector2.LEFT,
	"Up": Vector2.UP,
	"Down": Vector2.DOWN,
}

func _handle_effect(stage: Stage, entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "tick" }:
			if once:
				once = false
				var map := stage.get_map()
				var new_beam_pos = entity.tile + DIRS[dir]
				while map.get_tile_type(new_beam_pos) != Map.DEEP_PIT_TILES[0]:
					print_debug(new_beam_pos)
					var beam := beam_scn.instance() as Node2D
					beam.tile = new_beam_pos
					stage.add_child(beam)
					beam.apply_effect(stage, {
						type = "set_direction",
						dir = DIRS[dir]
					})
					new_beam_pos += DIRS[dir]
