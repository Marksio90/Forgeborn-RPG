extends Node
class_name RewardRepository

const REWARDS_PATH := "res://data/rewards/reward_tables.json"
const REQUIRED_FIELDS: Array[String] = [
	"id",
	"gold_min",
	"gold_max",
	"xp_min",
	"xp_max",
	"item_drop_chance",
	"possible_items"
]

var reward_tables_by_id: Dictionary = {}

func _ready() -> void:
	load_reward_tables()

func load_reward_tables() -> void:
	reward_tables_by_id.clear()
	var root: Variant = JsonDataLoader.load_json_file(REWARDS_PATH)
	if root == null:
		return

	var records: Array = _resolve_reward_list(root)
	for table_data: Variant in records:
		if typeof(table_data) != TYPE_DICTIONARY:
			push_error("Skipping reward table with invalid type in %s" % REWARDS_PATH)
			continue

		var table: Dictionary = table_data
		if not DataValidation.has_required_fields(table, REQUIRED_FIELDS, "RewardRepository(%s)" % REWARDS_PATH):
			continue

		var table_id: String = str(table["id"])
		if table_id.is_empty():
			push_error("RewardRepository(%s) has empty id; skipping record." % REWARDS_PATH)
			continue

		if reward_tables_by_id.has(table_id):
			push_warning("Duplicate reward table id detected: %s. Overwriting previous record." % table_id)
		reward_tables_by_id[table_id] = table.duplicate(true)

func get_reward_table(table_id: String) -> Dictionary:
	if not reward_tables_by_id.has(table_id):
		return {}
	return (reward_tables_by_id[table_id] as Dictionary).duplicate(true)

func get_all_reward_tables() -> Array:
	var results: Array = []
	for value in reward_tables_by_id.values():
		results.append((value as Dictionary).duplicate(true))
	return results

func has_reward_table(table_id: String) -> bool:
	return reward_tables_by_id.has(table_id)

func get_reward_table_count() -> int:
	return reward_tables_by_id.size()

func _resolve_reward_list(root: Variant) -> Array:
	if typeof(root) == TYPE_ARRAY:
		return root
	if typeof(root) != TYPE_DICTIONARY:
		push_error("Unexpected reward tables JSON root type in %s" % REWARDS_PATH)
		return []

	if root.has("reward_tables") and typeof(root["reward_tables"]) == TYPE_ARRAY:
		return root["reward_tables"]

	if root.has("tables") and typeof(root["tables"]) == TYPE_ARRAY:
		return root["tables"]

	var dictionary_as_array: Array = []
	for key in root.keys():
		var value: Variant = root[key]
		if typeof(value) == TYPE_DICTIONARY:
			var record: Dictionary = value.duplicate(true)
			if not record.has("id"):
				record["id"] = str(key)
			dictionary_as_array.append(record)
	if dictionary_as_array.size() > 0:
		return dictionary_as_array

	push_error("Unexpected reward tables JSON shape in %s." % REWARDS_PATH)
	return []
