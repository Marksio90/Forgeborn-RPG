# Technical Design

## Engine
- Godot 4.6+ (Godot 4.x) project under `game/`

## High-level Modules
- Core: app lifecycle and scene routing.
- Battle: turn sequencing and damage resolution.
- Data: JSON-driven repositories for heroes, enemies, items, and levels.
- Save/Progression: persistent player state and unlocks.

## Prompt 1 Navigation Layer
- `SceneRouter` is configured as an autoload singleton that owns scene transitions.
- `MainMenu` binds button signals to SceneRouter methods for Campaign, Heroes, Inventory, Forge, Battle Test, and Settings.
- Placeholder feature scenes use a shared Back-to-menu button script to keep navigation behavior consistent.
- UI layout uses Godot `Control` containers with touch-friendly button sizing for portrait-oriented mobile UX.


## Prompt 2 Data Layer
- `GameData` autoload now initializes and owns static repositories for Heroes, Enemies, Items, Levels, and Rewards.
- `JsonDataLoader` handles file existence checks, parse safety, and error reporting for `res://data/*` JSON.
- `DataValidation` provides required-field checks used by repositories without duplicating validation loops.
- Repositories index records by stable `id`, expose get/list/has/count APIs, and return immutable copies to callers.


## Compatibility Note
- The project targets Godot 4.6. The `project.godot` file and autoloads must remain compatible with Godot 4.x.

## Prompt 2.10 Data Integrity Update
- Static repositories now load a fully consistent starter dataset: 3 heroes, 3 enemies, 3 items, 3 levels, and 4 reward tables.
- Required-field schema validation is enforced per repository with record-aware error messages.
- `GameData` now runs lightweight cross-reference checks (enemy reward tables, level reward tables, level enemy IDs, reward item IDs, and level unlock links).
