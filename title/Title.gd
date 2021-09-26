extends Control

export var game_scn: PackedScene

onready var starting := false

func _ready():
	$AnimationPlayer.play("intro")
	yield($AnimationPlayer, "animation_finished")
	if not starting:
		$AnimationPlayer.play("idle")

func _input(event):
	if not starting and event.is_action_pressed("use_power"):
		starting = true
		$AnimationPlayer.play("fadeout")
		yield($AnimationPlayer, "animation_finished")
		#warning-ignore:return_value_discarded
		get_tree().change_scene_to(game_scn)
