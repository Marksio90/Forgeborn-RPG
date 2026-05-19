# Balance Tables

## Starter Hero Baselines
| Hero | Role | HP | ATK | DEF |
|---|---|---:|---:|---:|
| Kael Ironhand | Vanguard | 120 | 14 | 10 |
| Lyra Asharrow | Ranger | 90 | 18 | 6 |
| Mira Lightgiver | Cleric | 100 | 10 | 8 |


## Prompt 2 Data Source Notes
- Balance values are sourced from JSON files under `game/data/` and loaded through repository classes.
- Current seed JSON is intentionally sparse; repositories log missing required gameplay fields for future balance completion.
- Prompt 3 should enrich hero/enemy/item/level/reward schemas with full numeric tuning fields.
