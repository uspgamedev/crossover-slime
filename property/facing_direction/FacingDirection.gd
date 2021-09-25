class_name FacingDirection extends Property

const LEFT	:= 0
const RIGHT	:= 1
const UP	:= 2
const DOWN	:= 3

const DIRS := [
	Vector2(-1, 0),
	Vector2(1, 0),
	Vector2(0, -1),
	Vector2(0, 1),
]

const FACING_ANIMATIONS := [
	"idle_left",
	"idle_right",
	"idle_up",
	"idle_down"
]

export var sprite_path: NodePath

export(int, "LEFT", "RIGHT", "UP", "DOWN") var facing := DOWN

func _process(_delta: float):
	get_node(sprite_path).animation = FACING_ANIMATIONS[facing]

func _handle_effect(_stage: Stage, _entity: Entity, effect: Dictionary):
	match effect:
		{ "type": "move", "dir": var dir }:
			facing = closest_dir(dir)
		{ "type": "check_dir", .. }:
			effect.dir = DIRS[facing]

func closest_dir(dir: Vector2) -> int:
	var maxalign := -1.0
	var closest := -1
	for i in DIRS.size():
		var v = DIRS[i]
		var align := dir.dot(v)
		if align > maxalign:
			maxalign = align
			closest = i
	return closest
