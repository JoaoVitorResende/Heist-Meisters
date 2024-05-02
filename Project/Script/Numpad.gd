extends Popup

var combination = []
var guess = []
onready var display = $VBoxContainer/DisplayContainer/Display
signal combination_correct
const numpad_open_audio = "res://Project/Art/SFX/threeTone1.ogg"
const numpad_wrong_audio = "res://Project/Art/SFX/twoTone1.ogg"
const status_light_open = "res://Project/Art/GFX/Interface/PNG/dotGreen.png"
const status_light_close = "res://Project/Art/GFX/Interface/PNG/dotRed.png"

func _ready():
	connect_buttons()
	reset_lock()

func connect_buttons():
	for child in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		if child is Button:
			child.connect("pressed", self, "buttons_pressed", [child.text])

func buttons_pressed(button):
	guess.append(int(button))
	update_display()

func check_guess():
	if guess == combination:
		emit_signal("combination_correct")
		play_audio(numpad_open_audio)
		reset_lock()
	else:
		play_audio(numpad_wrong_audio)
		reset_lock()

func update_display():
	display.text = PoolStringArray(guess).join("")
	if guess.size() == combination.size():
		check_guess()

func play_audio(value):
	$AudioStreamPlayerNumPad.stream = load(value)
	$AudioStreamPlayerNumPad.play()

func reset_lock():
	display.text = ""
	guess.clear()
