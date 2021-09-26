extends Particles2D


func _ready():
	emitting = true
	#warning-ignore:return_value_discarded
	get_tree() \
		.create_timer(2.0) \
		.connect("timeout", self, "_animation_ended", [], CONNECT_ONESHOT)

func _animation_ended():
	queue_free()
