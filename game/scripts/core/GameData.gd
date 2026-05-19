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
