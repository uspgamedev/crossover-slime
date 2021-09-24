extends Node2D

export var player_path := NodePath()

func _process(delta):
	for node in get_tree().get_nodes_in_group(Entity.GROUP):
		if node is Entity:
			node._process_entity($Map, delta)
