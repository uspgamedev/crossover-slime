extends Control

export(Array, PackedScene) var stages

var current_stage: Stage = null

onready var next_stage_idx := 0

func _physics_process(_delta):
	if current_stage != null:
		move_player()

func move_player():
	var player := current_stage.get_player()
	if player != null and not player.moving:
		var move_dir := Vector2.ZERO
		move_dir.x	= Input.get_action_strength("move_right") \
					- Input.get_action_strength("move_left")
		move_dir.y	= Input.get_action_strength("move_down") \
					- Input.get_action_strength("move_up")
		if move_dir.x * move_dir.y == 0 and move_dir.length_squared() > 0:
			current_stage.apply_effect(player, { type = "move", dir = move_dir })

func _process(_delta):
	if current_stage == null:
		if next_stage_idx >= stages.size():
			get_tree().quit()
			return
		var stage_scn := stages[next_stage_idx] as PackedScene
		current_stage = stage_scn.instance()
		next_stage_idx += 1
		add_child(current_stage)

func _input(event):
	if event.is_action_pressed("use_power"):
		var player := current_stage.get_player()
		if player != null and not player.moving:
			current_stage.apply_effect(player, { type = "use_power" })
