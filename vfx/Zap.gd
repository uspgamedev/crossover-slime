extends Node2D

var tile_size := 64
var flip := true

func _ready():
	$AnimationPlayer.play("zap")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

func target() -> Position2D:
	return $Target as Position2D

func generate_zap():
	var n := int($Target.position.length() / tile_size * 2)
	var points := PoolVector2Array()
	var step := $Target.position.normalized() as Vector2
	points.resize(n+1)
	flip = not flip
	for i in n:
		var p := step * i as int * tile_size / 2 * (1 + rand_range(-1, 1) * 0.05)
		var ortho := step.rotated(PI/2)
		var side = 1 - 2 * (i % 2)
		if flip: side = -side
		p += ortho * side * (.2 + .1 * rand_range(-1, 1)) * tile_size
		points.append(p)
	points.append($Target.position)
	$Line2D.points = points
