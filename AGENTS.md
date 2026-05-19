# AGENTS Rules

## Scope
These instructions apply to the entire repository.

## Rules for AI Agents
1. Keep all Godot project content under `game/`.
2. Ensure Godot scene (`.tscn`) and script (`.gd`) files are Godot 4.x compatible.
3. Avoid broken scene/script references; use placeholders when systems are not yet implemented.
4. Keep JSON data human-readable and valid UTF-8.
5. Update docs in `docs/` whenever architecture or scope changes.
6. Preserve lightweight CI checks in `.github/workflows/repository-check.yml`.
7. Do not commit secrets, credentials, or signing keys.
