extends Control

@onready var debug_label: Label = get_node_or_null("MarginContainer/VBox/Description")

func _ready() -> void:
	if debug_label == null:
		return

	var count: int = 0
	if GameData != null and GameData.heroes != null and GameData.heroes.has_method("get_hero_count"):
		count = int(GameData.heroes.call("get_hero_count"))

	debug_label.text = "Heroes loaded: " + str(count)
