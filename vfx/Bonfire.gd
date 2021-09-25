extends Particles2D

export var duration := 1.0

func _ready():
	emitting = true
	yield(get_tree().create_timer(duration), "timeout")
	emitting = false
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
