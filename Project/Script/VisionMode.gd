extends CanvasModulate

const normal_vision = Color("111111")
const night_vision_mode = Color("46c029")
const night_vision_sound = "res://Project/Art/SFX/nightvision.wav"
const normal_vision_sound = "res://Project/Art/SFX/nightvision_off.wav"

func change_to_normal_vision():
	color = normal_vision
	audio_player(normal_vision_sound)

func change_to_night_vision():
	color = night_vision_mode
	audio_player(night_vision_sound)

func audio_player(sound_path):
	$AudioStreamPlayer.stream = load(sound_path)
	$AudioStreamPlayer.play()

func cycle_vision_mode():
	if color == night_vision_mode:
		change_to_normal_vision()
	else:
		change_to_night_vision()
