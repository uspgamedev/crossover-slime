extends AnimationPlayer

func bounce():
	stop()
	play("hop")

func _animation_finished(anim_name):
	if anim_name == "hop":
		play("standard")
