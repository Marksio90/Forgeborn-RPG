extends Node

var heroes: Node
var enemies: Node
var items: Node
var levels: Node
var rewards: Node

func _ready() -> void:
	print("GameData autoload initialized.")
	_initialize_repositories()
	_print_data_summary()
	_validate_cross_references()

func _initialize_repositories() -> void:
	heroes = _load_repository("res://scripts/heroes/HeroRepository.gd")
	enemies = _load_repository("res://scripts/enemies/EnemyRepository.gd")
	items = _load_repository("res://scripts/items/ItemRepository.gd")
	levels = _load_repository("res://scripts/campaign/LevelRepository.gd")
	rewards = _load_repository("res://scripts/economy/RewardRepository.gd")

func _load_repository(script_path: String) -> Node:
	if not ResourceLoader.exists(script_path):
		push_warning("Repository script missing: " + script_path)
		return null

	var script_resource: Resource = load(script_path)
	if script_resource == null:
		push_error("Failed to load repository script: " + script_path)
		return null

	if not script_resource is Script:
		push_error("Loaded resource is not a script: " + script_path)
		return null

	var repository_script: Script = script_resource as Script
	var instance: Variant = repository_script.new()
	if not instance is Node:
		push_error("Repository does not instantiate to Node: " + script_path)
		return null

	var repository_node: Node = instance as Node
	add_child(repository_node)
	return repository_node

func _print_data_summary() -> void:
	print("GameData repositories loaded:")
	print("- Heroes: ", _safe_count(heroes, "get_hero_count"))
	print("- Enemies: ", _safe_count(enemies, "get_enemy_count"))
	print("- Items: ", _safe_count(items, "get_item_count"))
	print("- Levels: ", _safe_count(levels, "get_level_count"))
	print("- Reward tables: ", _safe_count(rewards, "get_reward_table_count"))

func _safe_count(repository: Node, method_name: String) -> int:
	if repository == null:
		return 0
	if not repository.has_method(method_name):
		return 0
	return int(repository.call(method_name))

func _validate_cross_references() -> void:
	if enemies != null and rewards != null:
		var enemy_list: Array = enemies.get_all_enemies()
		for enemy_raw: Variant in enemy_list:
			var enemy: Dictionary = enemy_raw as Dictionary
			var reward_table_id: String = str(enemy.get("reward_table", ""))
			if reward_table_id != "" and not rewards.has_reward_table(reward_table_id):
				push_error("Enemy '%s' references missing reward table '%s'" % [str(enemy.get("id", "unknown")), reward_table_id])

	if levels != null:
		var level_list: Array = levels.get_all_levels()
		for level_raw: Variant in level_list:
			var level: Dictionary = level_raw as Dictionary
			var level_id: String = str(level.get("id", "unknown"))
			var reward_table_id: String = str(level.get("reward_table", ""))
			if rewards != null and reward_table_id != "" and not rewards.has_reward_table(reward_table_id):
				push_error("Level '%s' references missing reward table '%s'" % [level_id, reward_table_id])
			var enemy_ids: Array = level.get("enemy_ids", []) as Array
			if enemies != null:
				for enemy_id_raw: Variant in enemy_ids:
					var enemy_id: String = str(enemy_id_raw)
					if not enemies.has_enemy(enemy_id):
						push_error("Level '%s' references missing enemy '%s'" % [level_id, enemy_id])
			var unlock_id: String = str(level.get("unlocks_after_completion", ""))
			if unlock_id != "" and not levels.has_level(unlock_id):
				push_error("Level '%s' unlocks missing level '%s'" % [level_id, unlock_id])

	if rewards != null and items != null:
		var reward_table_list: Array = rewards.get_all_reward_tables()
		for reward_table_raw: Variant in reward_table_list:
			var reward_table: Dictionary = reward_table_raw as Dictionary
			var reward_table_id: String = str(reward_table.get("id", "unknown"))
			var possible_items: Array = reward_table.get("possible_items", []) as Array
			for item_id_raw: Variant in possible_items:
				var item_id: String = str(item_id_raw)
				if not items.has_item(item_id):
					push_error("Reward table '%s' references missing item '%s'" % [reward_table_id, item_id])
