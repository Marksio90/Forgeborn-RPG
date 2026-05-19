extends RefCounted
class_name DamageCalculator

func calculate(base_damage: int, attack: int, defense: int) -> int:
	var mitigated: int = max(0, attack - defense)
	return max(1, base_damage + mitigated)
