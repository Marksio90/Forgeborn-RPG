# Implementation Plan (Prompt 0–12)

## Prompt 0
- Goal: Establish repository structure.
- Scope: Create game/docs/tools/workflows scaffolding.
- Files: project, scenes, scripts, data, docs.
- Acceptance: All required directories and placeholders exist.

## Prompt 1
- Goal: Bootstrap Godot autoload and main menu flow.
- Scope: Wire Game and SceneRouter singletons.
- Files: `game/project.godot`, `game/scripts/core/*`, `game/scenes/main_menu/*`.
- Acceptance: Project launches to MainMenu scene.

## Prompt 2
- Goal: Battle skeleton.
- Scope: Connect BattleScene, BattleController, TurnManager.
- Files: `game/scenes/battle/*`, `game/scripts/battle/*`.
- Acceptance: Entering battle scene runs turn progression loop.

## Prompt 3
- Goal: Hero data layer.
- Scope: Parse heroes.json and instantiate hero records.
- Files: `game/data/heroes/heroes.json`, `game/scripts/heroes/*`.
- Acceptance: Hero repository returns three starter heroes.

## Prompt 4
- Goal: Enemy data layer.
- Scope: Parse enemies.json and expose enemy lookup by id.
- Files: `game/data/enemies/enemies.json`, `game/scripts/enemies/*`.
- Acceptance: Enemy repository resolves seeded enemies.

## Prompt 5
- Goal: Item and inventory foundation.
- Scope: Parse items and display inventory placeholder.
- Files: `game/data/items/items.json`, `game/scripts/items/*`, `game/scenes/inventory/*`.
- Acceptance: Inventory scene lists starter items.

## Prompt 6
- Goal: Campaign map stub.
- Scope: Add level metadata loading for Forest of Ash.
- Files: `game/data/levels/*`, `game/scenes/campaign/*`.
- Acceptance: Campaign map can enumerate three levels.

## Prompt 7
- Goal: Rewards and economy.
- Scope: Reward table loading and wallet updates.
- Files: `game/data/rewards/*`, `game/scripts/economy/*`.
- Acceptance: Battle victory grants gold and optional drops.

## Prompt 8
- Goal: Progression and save layer.
- Scope: PlayerProgress serialization with SaveManager.
- Files: `game/scripts/progression/*`, `game/scripts/save/*`.
- Acceptance: Save/load retains unlock state.

## Prompt 9
- Goal: Hero roster UI.
- Scope: Build HeroRoster scene interactions.
- Files: `game/scenes/heroes/*`, `game/scripts/heroes/*`, `game/scenes/ui/*`.
- Acceptance: Player can inspect owned heroes.

## Prompt 10
- Goal: Forge feature prototype.
- Scope: ForgeScreen with simple item enhancement flow.
- Files: `game/scenes/forge/*`, `game/scripts/items/*`, `game/scripts/economy/*`.
- Acceptance: Upgrade action consumes currency and updates stats.

## Prompt 11
- Goal: Platform preparation.
- Scope: Android/Windows export presets and QA checklist.
- Files: `game/exports/*`, `docs/GOOGLE_PLAY_CHECKLIST.md`.
- Acceptance: Export templates and checklist are in place.

## Prompt 12
- Goal: MVP stabilization.
- Scope: Balance pass, bug fixes, and smoke checks.
- Files: `docs/BALANCE_TABLES.md`, workflow validation.
- Acceptance: CI passes and MVP scope locked.

## Prompt 1 Update (Completed on 2026-05-19)
- Implemented Main Menu UI with title, subtitle, MVP version label, and navigation buttons.
- Implemented SceneRouter singleton API for all placeholder destination scenes.
- Added settings placeholder scene and reusable Back to Main Menu button behavior.
- Updated project settings for portrait-friendly mobile prototype layout (720x1280, canvas_items/expand).
