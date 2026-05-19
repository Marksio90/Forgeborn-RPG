extends Node
class_name ItemRepository

const ITEMS_PATH := "res://data/items/items.json"
const REQUIRED_FIELDS: Array[String] = ["id", "name", "slot", "rarity", "bonuses"]

var items_by_id: Dictionary = {}

func _ready() -> void:
	load_items()

func load_items() -> void:
	items_by_id.clear()
	var root := JsonDataLoader.load_json_file(ITEMS_PATH)
	if root == null:
		return

	var records := _resolve_record_list(root, "items", ITEMS_PATH)
	for item_data in records:
		if typeof(item_data) != TYPE_DICTIONARY:
			push_error("Skipping item record with invalid type in %s" % ITEMS_PATH)
			continue

		var item: Dictionary = item_data
		var source_name := "ItemRepository(%s)" % ITEMS_PATH
		DataValidation.has_required_fields(item, REQUIRED_FIELDS, "%s record" % source_name)

		if not item.has("id"):
			push_error("%s missing id; skipping record." % source_name)
			continue

		var item_id := str(item["id"])
		if item_id.is_empty():
			push_error("%s has empty id; skipping record." % source_name)
			continue

		if items_by_id.has(item_id):
			push_warning("Duplicate item id detected: %s. Overwriting previous record." % item_id)
		items_by_id[item_id] = item.duplicate(true)

func get_item(item_id: String) -> Dictionary:
	if not items_by_id.has(item_id):
		return {}
	return (items_by_id[item_id] as Dictionary).duplicate(true)

func get_all_items() -> Array:
	var results: Array = []
	for value in items_by_id.values():
		results.append((value as Dictionary).duplicate(true))
	return results

func has_item(item_id: String) -> bool:
	return items_by_id.has(item_id)

func get_item_count() -> int:
	return items_by_id.size()

func _resolve_record_list(root: Variant, key: String, path: String) -> Array:
	if typeof(root) == TYPE_ARRAY:
		return root
	if typeof(root) == TYPE_DICTIONARY and root.has(key) and typeof(root[key]) == TYPE_ARRAY:
		return root[key]
	push_error("Unexpected items JSON shape in %s. Expected Array or Dictionary[%s]." % [path, key])
	return []
