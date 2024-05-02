extends NinePatchRect

const loot_icon = "res://Project/Art/GFX/Loot/suitcase.png"

func _ready():
	hide()

func collect_loot():
	show()
	$VBoxContainer/ItemList.add_icon_item(load(loot_icon), false)
