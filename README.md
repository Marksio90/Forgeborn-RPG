# Forgeborn RPG

Forgeborn RPG is a Godot 4.x turn-based RPG prototype focused on hero collection, tactical battles, and campaign progression.

## MVP Scope
- Main menu and navigable placeholder scenes.
- Battle module skeleton with turn management and damage calculation stubs.
- Data-driven starter content for heroes, enemies, items, levels, and rewards.
- Foundational progression, economy, and save systems.

## Platforms
- Windows (planned export target)
- Android / Google Play (planned export target)

## Open / Run Instructions
1. Install Godot 4.x.
2. Open the `game/` directory as a Godot project.
3. Run the project; it starts at `MainMenu.tscn`.

## Roadmap
1. Implement scene routing and menu actions.
2. Build battle loop and enemy AI behaviors.
3. Add inventory, roster management, and forge upgrades.
4. Add persistence, balancing passes, and platform QA.

## Exclusions (Current MVP)
- Live service / online multiplayer.
- Advanced VFX/audio polish.
- Full production content pipeline and monetization.

## Prompt 1 Status (Implemented)
- Added a mobile-friendly main menu shell with routing buttons.
- Added reusable scene routing via `SceneRouter` autoload.
- Added consistent placeholder screens with Back to Main Menu navigation.
- Tuned project window/stretch defaults for portrait prototype testing.
