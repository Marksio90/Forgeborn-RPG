extends Control

@onready var description_label: Label = $MarginContainer/VBox/Description

func _ready() -> void:
	var lines: Array[String] = []
	if GameData == null or GameData.heroes == null:
		description_label.text = "Heroes loaded: 0\n(GameData unavailable)"
		return

	var heroes: Array = GameData.heroes.get_all_heroes()
	lines.append("Heroes loaded: %d" % heroes.size())
	for hero in heroes:
		var hero_name: String = str((hero as Dictionary).get("name", "Unknown Hero"))
		lines.append("• %s" % hero_name)
	description_label.text = "\n".join(lines)
