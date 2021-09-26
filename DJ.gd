extends Node

onready var debug = $debug
onready var songs_list = $songs

var songs = { }
var default_volumes = { }

var current = ""

var next = ""


var resume_instant = 0
var dual_main_instant = 0
var dual_second_instant = 0
var is_paused = false
var is_switch = false


func _ready():
	for s in songs_list.get_children():
		songs[str(s.name)] = s
		default_volumes[str(s.name)] = s.get_volume_db()
		
	play("base")


func stop():
	if current: current.stop()
	if next: next.stop()


func play(name: String, from: float = 0.0):
	is_switch = false
	
	if songs.has(name):
		current = name
		songs[name].play(from)
	else:
		print_debug("Song \'" + name + "\' not found")


func play_with_cross_fade(name: String, duration: float = 0.5):
	if songs[name]:
		next = name
		
		if current && next == current: return
		
		$TweenCrossCurr.interpolate_method(songs[current], "set_volume_db",
			songs[current].get_volume_db(), -80, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration)
		$TweenCrossNext.interpolate_method(songs[next], "set_volume_db",
			-80, default_volumes[next], duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$TweenCrossCurr.start()
		$TweenCrossNext.start()
		
		songs[next].play(songs[current].get_playback_position())
		print_debug(current, next)
	else:
		print_debug("Song \'" + name + "\' not found")


func _on_TweenCrossCurr_tween_completed(_object, _key):
	songs[current].stop()
	songs[current].set_volume_db(default_volumes[current])
	
	current = next
