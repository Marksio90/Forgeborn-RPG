extends Node
class_name EnemyRepository

const ENEMIES_PATH := "res://data/enemies/enemies.json"
const REQUIRED_FIELDS: Array[String] = [
	"id", "name", "base_hp", "base_attack", "base_defense", "base_speed", "reward_table"
]

var enemies_by_id: Dictionary = {}

func _ready() -> void:
	load_enemies()

func load_enemies() -> void:
	enemies_by_id.clear()
	var root: Variant = JsonDataLoader.load_json_file(ENEMIES_PATH)
	if root == null:
		return

	var records: Array = _resolve_record_list(root, "enemies", ENEMIES_PATH)
	for enemy_data: Variant in records:
		if typeof(enemy_data) != TYPE_DICTIONARY:
			push_error("Skipping enemy record with invalid type in %s" % ENEMIES_PATH)
			continue

		var enemy: Dictionary = enemy_data
		var source_name := "EnemyRepository(%s)" % ENEMIES_PATH
		DataValidation.has_required_fields(enemy, REQUIRED_FIELDS, "%s record" % source_name)

		if not enemy.has("id"):
			push_error("%s missing id; skipping record." % source_name)
			continue

		var enemy_id: String = str(enemy["id"])
		if enemy_id.is_empty():
			push_error("%s has empty id; skipping record." % source_name)
			continue

		if enemies_by_id.has(enemy_id):
			push_warning("Duplicate enemy id detected: %s. Overwriting previous record." % enemy_id)
		enemies_by_id[enemy_id] = enemy.duplicate(true)

func get_enemy(enemy_id: String) -> Dictionary:
	if not enemies_by_id.has(enemy_id):
		return {}
	return (enemies_by_id[enemy_id] as Dictionary).duplicate(true)

func get_all_enemies() -> Array:
	var results: Array = []
	for value in enemies_by_id.values():
		results.append((value as Dictionary).duplicate(true))
	return results

func has_enemy(enemy_id: String) -> bool:
	return enemies_by_id.has(enemy_id)

func get_enemy_count() -> int:
	return enemies_by_id.size()

func _resolve_record_list(root: Variant, key: String, path: String) -> Array:
	if typeof(root) == TYPE_ARRAY:
		return root
	if typeof(root) == TYPE_DICTIONARY and root.has(key) and typeof(root[key]) == TYPE_ARRAY:
		return root[key]
	push_error("Unexpected enemies JSON shape in %s. Expected Array or Dictionary[%s]." % [path, key])
	return []
