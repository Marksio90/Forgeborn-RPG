extends Control

@onready var campaign_button: Button = %CampaignButton
@onready var heroes_button: Button = %HeroesButton
@onready var inventory_button: Button = %InventoryButton
@onready var forge_button: Button = %ForgeButton
@onready var battle_test_button: Button = %BattleTestButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	campaign_button.pressed.connect(_on_campaign_pressed)
	heroes_button.pressed.connect(_on_heroes_pressed)
	inventory_button.pressed.connect(_on_inventory_pressed)
	forge_button.pressed.connect(_on_forge_pressed)
	battle_test_button.pressed.connect(_on_battle_test_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	if OS.has_feature("web") or OS.has_feature("android") or OS.has_feature("ios"):
		quit_button.disabled = true
		quit_button.text = "Quit (Desktop Only)"

func _on_campaign_pressed() -> void:
	SceneRouter.go_to_campaign()

func _on_heroes_pressed() -> void:
	SceneRouter.go_to_heroes()

func _on_inventory_pressed() -> void:
	SceneRouter.go_to_inventory()

func _on_forge_pressed() -> void:
	SceneRouter.go_to_forge()

func _on_battle_test_pressed() -> void:
	SceneRouter.go_to_battle_test()

func _on_settings_pressed() -> void:
	SceneRouter.go_to_settings()

func _on_quit_pressed() -> void:
	if OS.has_feature("web") or OS.has_feature("android") or OS.has_feature("ios"):
		return
	get_tree().quit()
