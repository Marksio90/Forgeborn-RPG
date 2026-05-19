extends RefCounted
class_name TurnManager

var turn_index: int = 0

func next_turn() -> int:
	turn_index += 1
	return turn_index
