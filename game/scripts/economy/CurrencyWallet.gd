extends RefCounted
class_name CurrencyWallet

var gold: int = 0

func add_gold(amount: int) -> void:
	gold += max(0, amount)
