# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Factorio 2.0 Space Age mod: **Complex Space Age Science Packs**. It increases complexity of Space Age science packs by requiring all 6 base packs as ingredients, adds planet-specific module crafting restrictions, modifies asteroid recipes, tweaks tech unlocks, and optionally makes biolabs consume nutrients.

Lua API reference: https://lua-api.factorio.com/latest/

## Packaging

```bash
zip -r complex-space-age-science-packs_1.0.0.zip complex-space-age-science-packs_1.0.0/
```

There is no build system, test runner, or linter. Changes are tested by loading the mod in Factorio.

## Mod structure and load order

Factorio loads mod files in a fixed order. Each stage runs after all mods complete the previous stage:

| File | Stage | Purpose |
|---|---|---|
| `settings.lua` | Settings | Declares startup settings (`ga-biolabs-*`) |
| `data.lua` | Data | Entry point; requires `prototypes/recipe.lua`; applies biolab nutrient energy source if setting is on |
| `data-updates.lua` | Data Updates | Modifies existing recipes after other mods' `data.lua` runs |
| `data-final-fixes.lua` | Data Final Fixes | Last to run; wins all conflicts; rewrites tech trees, module restrictions, Gleba map gen |

`prototypes/recipe.lua` is called from `data.lua` and adds `additional_categories` and `crafting_machine_tint` to various recipes (Gleba biochamber compatibility).

## Key design patterns

**Guarded modifications** — every `data.raw` access checks existence before modifying (`if data.raw["recipe"]["foo"] then`). This makes the mod safe when running alongside mods that remove or rename prototypes.

**Optional mod compatibility** — `mods["harder-pack"]` checks switch which recipe variant gets the ingredient additions. Other optional dependencies (`glebaadditions`, `Rocs-Improved-Platform-Drag`, etc.) are handled similarly.

**Stage strategy** — use `data-updates.lua` when you want to run after other mods' initial data but still allow overrides; use `data-final-fixes.lua` when your change must win regardless of other mods.

## What each file changes

- **`data-updates.lua`**: Adds all 6 base science packs as ingredients to space/metallurgic/agricultural/electromagnetic/cryogenic science pack recipes. Buffs advanced carbonic asteroid crushing (carbon 5→9, sulfur 2→3). Reduces coal synthesis carbon cost (5→3). Adds 4% carbon chance to scrap recycling.

- **`data-final-fixes.lua`**: Biolab drain rate 50%→80%. Asteroid-reprocessing converted to trigger tech (collect 10 metallic chunks). Advanced asteroid processing loses 3 crushing recipe unlocks (moved to asteroid-reprocessing). Module tier-2 locked to space platforms (gravity=0); tier-3 locked per planet (productivity→Nauvis gravity=10, speed→Vulcanus gravity=40, quality→Fulgora gravity=8, efficiency→Gleba gravity=20). Efficiency module nerf (tier1 -30%→-20%, tier2 -40%→-35%). Coal liquefaction technology removed (recipe unlocked via asteroid-reprocessing instead). Gleba gets larger stone patches in map gen. Burnt spoilage recipe changed to 15 nutrients + 1 spoilage → 2 carbon.

## Settings

Defined in `settings.lua`, localized in `locale/en/glebaadditions.cfg`:

- `ga-biolabs-require-nutrients` (bool, default `true`) — biolabs burn nutrients instead of electricity
- `ga-biolabs-energy-consumption` (int, default `1000` kW) — nutrient consumption rate when above setting is on