extends Node2D

func get_audio(audio_name) -> AudioStreamPlayer2D:
	return get_node(audio_name)

func play(audio_name: String, restart: bool = true) -> void:
	var node: AudioStreamPlayer2D = get_node(audio_name) 
	if !node.playing || restart:
		node.play()

func stop(audio_name: String) -> void:
	get_node(audio_name).stop()
