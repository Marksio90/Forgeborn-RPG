extends Node
class_name HeroRepository

const HEROES_PATH := "res://data/heroes/heroes.json"
const REQUIRED_FIELDS: Array[String] = [
	"id", "name", "class", "faction", "rarity", "base_hp", "base_attack", "base_defense", "base_speed", "skill_id"
]

var heroes_by_id: Dictionary = {}

func _ready() -> void:
	load_heroes()

func load_heroes() -> void:
	heroes_by_id.clear()
	var root: Variant = JsonDataLoader.load_json_file(HEROES_PATH)
	if root == null:
		return

	var records: Array = _resolve_record_list(root, "heroes", HEROES_PATH)
	for hero_data: Variant in records:
		if typeof(hero_data) != TYPE_DICTIONARY:
			push_error("Skipping hero record with invalid type in %s" % HEROES_PATH)
			continue

		var hero: Dictionary = hero_data
		var source_name := "HeroRepository(%s)" % HEROES_PATH
		DataValidation.has_required_fields(hero, REQUIRED_FIELDS, "%s record" % source_name)

		if not hero.has("id"):
			push_error("%s missing id; skipping record." % source_name)
			continue

		var hero_id: String = str(hero["id"])
		if hero_id.is_empty():
			push_error("%s has empty id; skipping record." % source_name)
			continue

		if heroes_by_id.has(hero_id):
			push_warning("Duplicate hero id detected: %s. Overwriting previous record." % hero_id)
		heroes_by_id[hero_id] = hero.duplicate(true)

func get_hero(hero_id: String) -> Dictionary:
	if not heroes_by_id.has(hero_id):
		return {}
	return (heroes_by_id[hero_id] as Dictionary).duplicate(true)

func get_all_heroes() -> Array:
	var results: Array = []
	for value in heroes_by_id.values():
		results.append((value as Dictionary).duplicate(true))
	return results

func has_hero(hero_id: String) -> bool:
	return heroes_by_id.has(hero_id)

func get_hero_count() -> int:
	return heroes_by_id.size()

func _resolve_record_list(root: Variant, key: String, path: String) -> Array:
	if typeof(root) == TYPE_ARRAY:
		return root
	if typeof(root) == TYPE_DICTIONARY and root.has(key) and typeof(root[key]) == TYPE_ARRAY:
		return root[key]
	push_error("Unexpected heroes JSON shape in %s. Expected Array or Dictionary[%s]." % [path, key])
	return []
