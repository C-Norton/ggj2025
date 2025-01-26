extends Node3D

@export var tracks : Array[Music]
signal music_changed(direction)
var new_playlist = []
@export var song_index = 0
var song_name = "temp"


func set_song():
	song_name = tracks[song_index].name
	var audio_stream = load(tracks[song_index].file_path)
	song_index += 1
	if song_index == 3:
		song_index = 0
		
	play_music(audio_stream)
		
func skip_song():
	song_index += 1
	if song_index == 3:
		song_index = 0
	set_song()
	
func prev_song():
	song_index -= 1
	if song_index == -1:
		song_index = 3
	set_song()
	
	
	
func play_music(song):
	$AudioStreamPlayer3D.stream = song
	$AudioStreamPlayer3D.play()
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_song()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_audio_stream_player_3d_finished() -> void:
	set_song()
