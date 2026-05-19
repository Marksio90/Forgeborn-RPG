extends Node
const MAIN_MENU_SCENE: String = "res://scenes/main_menu/MainMenu.tscn"
const CAMPAIGN_SCENE: String = "res://scenes/campaign/CampaignMap.tscn"
const HEROES_SCENE: String = "res://scenes/heroes/HeroRoster.tscn"
const INVENTORY_SCENE: String = "res://scenes/inventory/InventoryScreen.tscn"
const FORGE_SCENE: String = "res://scenes/forge/ForgeScreen.tscn"
const BATTLE_SCENE: String = "res://scenes/battle/BattleScene.tscn"
const SETTINGS_SCENE: String = "res://scenes/ui/SettingsScreen.tscn"

func go_to_main_menu() -> void:
	_change_scene(MAIN_MENU_SCENE)

func go_to_campaign() -> void:
	_change_scene(CAMPAIGN_SCENE)

func go_to_heroes() -> void:
	_change_scene(HEROES_SCENE)

func go_to_inventory() -> void:
	_change_scene(INVENTORY_SCENE)

func go_to_forge() -> void:
	_change_scene(FORGE_SCENE)

func go_to_battle_test() -> void:
	_change_scene(BATTLE_SCENE)

func go_to_settings() -> void:
	_change_scene(SETTINGS_SCENE)

func _change_scene(scene_path: String) -> void:
	if not ResourceLoader.exists(scene_path):
		push_error("Scene path does not exist: " + scene_path)
		return

	var error: Error = get_tree().change_scene_to_file(scene_path)
	if error != OK:
		push_error("Failed to change scene to: %s (error %d)" % [scene_path, error])
