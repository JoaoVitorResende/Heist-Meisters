extends TextureProgress

export var suspicion_multiplier = 2

func _ready():
	value = 0

func _process(delta):
	value -= step

func player_seen():
	value += step * suspicion_multiplier
	check_suspicion_value()

func check_suspicion_value():
	if value == max_value:
		end_game()

func end_game():
	print("snakeeee")
