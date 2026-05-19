extends Node

var heroes: HeroRepository
var enemies: EnemyRepository
var items: ItemRepository
var levels: LevelRepository
var rewards: RewardRepository

func _ready() -> void:
	heroes = HeroRepository.new()
	enemies = EnemyRepository.new()
	items = ItemRepository.new()
	levels = LevelRepository.new()
	rewards = RewardRepository.new()

	add_child(heroes)
	add_child(enemies)
	add_child(items)
	add_child(levels)
	add_child(rewards)

	print_data_summary()

func print_data_summary() -> void:
	print("GameData loaded:")
	print("- Heroes: ", heroes.get_hero_count())
	print("- Enemies: ", enemies.get_enemy_count())
	print("- Items: ", items.get_item_count())
	print("- Levels: ", levels.get_level_count())
	print("- Reward tables: ", rewards.get_reward_table_count())
