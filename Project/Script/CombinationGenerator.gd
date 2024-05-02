extends Node2D

func generate_combination(length):
	var combination = []
	for number in range(length):
		combination.append(randi() % 10)
	return combination
