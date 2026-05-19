extends Control

@onready var campaign_button: Button = get_node_or_null("%CampaignButton")
@onready var heroes_button: Button = get_node_or_null("%HeroesButton")
@onready var inventory_button: Button = get_node_or_null("%InventoryButton")
@onready var forge_button: Button = get_node_or_null("%ForgeButton")
@onready var battle_test_button: Button = get_node_or_null("%BattleTestButton")
@onready var settings_button: Button = get_node_or_null("%SettingsButton")
@onready var quit_button: Button = get_node_or_null("%QuitButton")

func _ready() -> void:
	_connect_if_present(campaign_button, _on_campaign_pressed)
	_connect_if_present(heroes_button, _on_heroes_pressed)
	_connect_if_present(inventory_button, _on_inventory_pressed)
	_connect_if_present(forge_button, _on_forge_pressed)
	_connect_if_present(battle_test_button, _on_battle_test_pressed)
	_connect_if_present(settings_button, _on_settings_pressed)
	_connect_if_present(quit_button, _on_quit_pressed)

	if quit_button != null and (OS.has_feature("web") or OS.has_feature("android") or OS.has_feature("ios")):
		quit_button.disabled = true
		quit_button.text = "Quit (Desktop Only)"

func _connect_if_present(button: Button, callback: Callable) -> void:
	if button == null:
		return
	if not button.pressed.is_connected(callback):
		button.pressed.connect(callback)

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
