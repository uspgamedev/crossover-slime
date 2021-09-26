extends Control

export(Array, PackedScene) var stages
export(String, FILE) var victory_scn_path

var current_stage: Stage = null

onready var next_stage_idx := 0

func _physics_process(_delta):
	if current_stage != null:
		current_stage.tick_entities()
	if current_stage != null:
		move_player()

func _clear_stage():
	var stage := current_stage
	current_stage = null
	$Tween.interpolate_property(
		stage, "position", Vector2.ZERO, Vector2.DOWN * 1000, 0.5,
		Tween.TRANS_BACK, Tween.EASE_IN
	)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	stage.queue_free()

func move_player():
	var player := current_stage.get_player()
	if player != null and not player.is_moving():
		var move_dir := Vector2.ZERO
		move_dir.x	= Input.get_action_strength("move_right") \
					- Input.get_action_strength("move_left")
		move_dir.y	= Input.get_action_strength("move_down") \
					- Input.get_action_strength("move_up")
		if move_dir.x * move_dir.y == 0 and move_dir.length_squared() > 0:
			current_stage.apply_effect(player, { type = "move", dir = move_dir })

func _process(_delta):
	if current_stage == null and not $Tween.is_active():
		if next_stage_idx >= stages.size():
			#warning-ignore:return_value_discarded
			get_tree().change_scene(victory_scn_path)
			return
		var stage_scn := stages[next_stage_idx] as PackedScene
		current_stage = stage_scn.instance()
		current_stage.position = Vector2.UP * 1000
		$Tween.interpolate_property(
			current_stage, "position", Vector2.UP * 1000, Vector2.ZERO, 1.0,
			Tween.TRANS_BOUNCE, Tween.EASE_OUT
		)
		$Tween.start()
		#warning-ignore:return_value_discarded
		current_stage.connect("won", self, "_clear_stage")
		#warning-ignore:return_value_discarded
		current_stage.connect("power_changed", $HUD, "set_power_name")
		$HUD.set_power_name("NONE")
		next_stage_idx += 1
		add_child(current_stage)

func _input(event):
	if event.is_action_pressed("use_power"):
		var player := current_stage.get_player()
		if player != null and not player.is_moving():
			current_stage.apply_effect(player, { type = "use_power" })
	if event.is_action_pressed("retry_stage"):
		_clear_stage()
		next_stage_idx -= 1
