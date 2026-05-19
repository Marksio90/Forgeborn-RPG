extends Node
class_name LevelRepository

const FOREST_LEVELS_PATH := "res://data/levels/levels_forest_of_ash.json"
const REQUIRED_FIELDS: Array[String] = ["id", "name", "region", "recommended_power", "enemy_ids", "reward_table"]

var levels_by_id: Dictionary = {}
var levels_by_region: Dictionary = {}

func _ready() -> void:
	load_levels()

func load_levels() -> void:
	levels_by_id.clear()
	levels_by_region.clear()
	var root: Variant = JsonDataLoader.load_json_file(FOREST_LEVELS_PATH)
	if root == null:
		return

	var records: Array = _resolve_record_list(root, "levels", FOREST_LEVELS_PATH)
	for level_data: Variant in records:
		if typeof(level_data) != TYPE_DICTIONARY:
			push_error("Skipping level record with invalid type in %s" % FOREST_LEVELS_PATH)
			continue

		var level: Dictionary = level_data
		var source_name := "LevelRepository(%s)" % FOREST_LEVELS_PATH
		DataValidation.has_required_fields(level, REQUIRED_FIELDS, "%s record" % source_name)

		if not level.has("id"):
			push_error("%s missing id; skipping record." % source_name)
			continue

		var level_id: String = str(level["id"])
		if level_id.is_empty():
			push_error("%s has empty id; skipping record." % source_name)
			continue

		if levels_by_id.has(level_id):
			push_warning("Duplicate level id detected: %s. Overwriting previous record." % level_id)
		levels_by_id[level_id] = level.duplicate(true)

		var region_id: String = str(level.get("region", "unknown"))
		if not levels_by_region.has(region_id):
			levels_by_region[region_id] = []
		(levels_by_region[region_id] as Array).append(level.duplicate(true))

func get_level(level_id: String) -> Dictionary:
	if not levels_by_id.has(level_id):
		return {}
	return (levels_by_id[level_id] as Dictionary).duplicate(true)

func get_all_levels() -> Array:
	var results: Array = []
	for value in levels_by_id.values():
		results.append((value as Dictionary).duplicate(true))
	return results

func get_levels_by_region(region_id: String) -> Array:
	if not levels_by_region.has(region_id):
		return []
	var values: Array = levels_by_region[region_id]
	var results: Array = []
	for value in values:
		results.append((value as Dictionary).duplicate(true))
	return results

func has_level(level_id: String) -> bool:
	return levels_by_id.has(level_id)

func get_level_count() -> int:
	return levels_by_id.size()

func _resolve_record_list(root: Variant, key: String, path: String) -> Array:
	if typeof(root) == TYPE_ARRAY:
		return root
	if typeof(root) == TYPE_DICTIONARY and root.has(key) and typeof(root[key]) == TYPE_ARRAY:
		return root[key]
	push_error("Unexpected levels JSON shape in %s. Expected Array or Dictionary[%s]." % [path, key])
	return []
