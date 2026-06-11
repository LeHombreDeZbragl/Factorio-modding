-- Complex Space Age science packs - data-final-fixes
-- by ThreeTimesWell
-- Runs after all other mods' data-updates, so these changes win conflicts.


-- ============================================================
-- 2. Biolab - increase science pack consumption from 50% to 80%
-- ============================================================
data.raw["lab"]["biolab"].science_pack_drain_rate_percent = 80


-- ============================================================
-- 3. Asteroid reprocessing - convert from normal research to trigger tech
--    Trigger  : collect 10 metallic-asteroid-chunk items
--               (asteroid collectors run recipes internally; their output
--               items count as "crafted" for research trigger purposes)
--    Prereqs  : space-science-pack only  (was metallurgic-science-pack)
--    New effects added: advanced crushing recipes, coal synthesis,
--                       coal liquefaction
-- ============================================================
local asteroid_reprocessing = data.raw["technology"]["asteroid-reprocessing"]
if asteroid_reprocessing then
    -- Convert to trigger-based (mutually exclusive with unit)
    asteroid_reprocessing.unit = nil
    asteroid_reprocessing.research_trigger = {
        type  = "craft-item",
        item  = "metallic-asteroid-chunk",
        count = 10,
    }

    -- New prerequisite chain: only requires reaching space
    asteroid_reprocessing.prerequisites = {"space-science-pack"}

    if not asteroid_reprocessing.effects then
        asteroid_reprocessing.effects = {}
    end
    local new_effects = {
        {type = "unlock-recipe", recipe = "advanced-metallic-asteroid-crushing"},
        {type = "unlock-recipe", recipe = "advanced-carbonic-asteroid-crushing"},
        {type = "unlock-recipe", recipe = "advanced-oxide-asteroid-crushing"},
        {type = "unlock-recipe", recipe = "coal-synthesis"},
        {type = "unlock-recipe", recipe = "coal-liquefaction"},
        {type = "unlock-recipe", recipe = "ice-melting"},
    }
    for _, effect in pairs(new_effects) do
        table.insert(asteroid_reprocessing.effects, effect)
    end
end


-- ============================================================
-- 4. Advanced asteroid processing - remove the 3 advanced crushing effects
--    (they are now unlocked by asteroid-reprocessing instead)
--    Kept: advanced-thruster-fuel, advanced-thruster-oxidizer
-- ============================================================
local adv_asteroid = data.raw["technology"]["advanced-asteroid-processing"]
if adv_asteroid and adv_asteroid.effects then
    local to_remove = {
        ["advanced-metallic-asteroid-crushing"] = true,
        ["advanced-carbonic-asteroid-crushing"]  = true,
        ["advanced-oxide-asteroid-crushing"]     = true,
    }
    local kept = {}
    for _, effect in pairs(adv_asteroid.effects) do
        if not (effect.type == "unlock-recipe" and to_remove[effect.recipe]) then
            table.insert(kept, effect)
        end
    end
    adv_asteroid.effects = kept
end


-- ============================================================
-- 5. Rocket turret - remove coal synthesis
--    (coal synthesis is now unlocked by asteroid-reprocessing)
-- ============================================================
local rocket_turret = data.raw["technology"]["rocket-turret"]
if rocket_turret and rocket_turret.effects then
    local kept = {}
    for _, effect in pairs(rocket_turret.effects) do
        if not (effect.type == "unlock-recipe" and effect.recipe == "coal-synthesis") then
            table.insert(kept, effect)
        end
    end
    rocket_turret.effects = kept
end


-- ============================================================
-- 7. Advanced oxide asteroid crushing - add stone x3 to results
--    Final results: ice x3, calcite x2, stone x3,
--                   oxidic-asteroid-chunk x1 @ 5% chance
-- ============================================================
local oxide_recipe = data.raw["recipe"]["advanced-oxide-asteroid-crushing"]
if oxide_recipe then
    table.insert(oxide_recipe.results, {type = "item", name = "stone", amount = 3})
end


-- ============================================================
-- 8. Advanced metallic asteroid crushing - copper-ore output 4 -> 10
--    Final results: iron-ore x10, copper-ore x10,
--                   metallic-asteroid-chunk x1 @ 5% chance
-- ============================================================
local metallic_recipe = data.raw["recipe"]["advanced-metallic-asteroid-crushing"]
if metallic_recipe and metallic_recipe.results then
    for _, result in pairs(metallic_recipe.results) do
        if result.name == "copper-ore" then
            result.amount = 10
        end
    end
end


-- ============================================================
-- 9. Gleba - larger stone patches
--    Stone: match Nauvis standard multipliers (frequency 1, size 1, richness 1)
-- ============================================================
local gleba = data.raw["planet"]["gleba"]
if gleba then
    if not gleba.map_gen_settings then
        gleba.map_gen_settings = {}
    end
    local mgs = gleba.map_gen_settings
    if not mgs.autoplace_settings then
        mgs.autoplace_settings = {}
    end
    if not mgs.autoplace_settings["entity"] then
        mgs.autoplace_settings["entity"] = {treat_missing_as_default = true, settings = {}}
    end
    local ent = mgs.autoplace_settings["entity"]
    if not ent.settings then
        ent.settings = {}
    end
    -- Stone patches same size as on Nauvis
    ent.settings["stone"] = {frequency = 1, size = 1, richness = 1}
end


-- ============================================================
-- 10. Module recipes - surface_conditions restrictions
--     Tier 2: craftable only on space platforms (gravity = 0)
--     Tier 3: each locked to one specific planet (by unique gravity value)
--       productivity-module-3 → Nauvis    (gravity 10)
--       speed-module-3        → Vulcanus  (gravity 40)
--       quality-module-3      → Fulgora   (gravity  8)
--       efficiency-module-3   → Gleba     (gravity 20)
-- ============================================================

-- Tier 2: space platform only
local tier2_modules = {
    "efficiency-module-2",
    "productivity-module-2",
    "speed-module-2",
    "quality-module-2",
}
for _, name in pairs(tier2_modules) do
    local recipe = data.raw["recipe"][name]
    if recipe then
        recipe.surface_conditions = {
            { property = "gravity", min = 0, max = 0 }
        }
    end
end

-- Tier 3: one planet each (gravity values are unique per planet)
local tier3_planet_gravity = {
    ["productivity-module-3"] = 10,  -- Nauvis
    ["speed-module-3"]        = 40,  -- Vulcanus
    ["quality-module-3"]      =  8,  -- Fulgora
    ["efficiency-module-3"]   = 20,  -- Gleba
}
for recipe_name, grav in pairs(tier3_planet_gravity) do
    local recipe = data.raw["recipe"][recipe_name]
    if recipe then
        recipe.surface_conditions = {
            { property = "gravity", min = grav, max = grav }
        }
    end
end


-- ============================================================
-- 11. Efficiency module nerf - reduce consumption bonus
--     Tier 1: 30% → 20%  (bonus -0.30 → -0.20)
--     Tier 2: 40% → 35%  (bonus -0.40 → -0.35)
--     Tier 3: 50%         (unchanged)
-- ============================================================
local eff1 = data.raw["module"]["efficiency-module"]
if eff1 and eff1.effect and eff1.effect.consumption then
    eff1.effect.consumption = -0.20
end

local eff2 = data.raw["module"]["efficiency-module-2"]
if eff2 and eff2.effect and eff2.effect.consumption then
    eff2.effect.consumption = -0.35
end


-- ============================================================
-- 12. Space platform thruster - remove ice-melting unlock
--     (ice-melting is now unlocked by asteroid-reprocessing)
-- ============================================================
local space_platform_thruster = data.raw["technology"]["space-platform-thruster"]
if space_platform_thruster and space_platform_thruster.effects then
    local kept = {}
    for _, effect in pairs(space_platform_thruster.effects) do
        if not (effect.type == "unlock-recipe" and effect.recipe == "ice-melting") then
            table.insert(kept, effect)
        end
    end
    space_platform_thruster.effects = kept
end


-- ============================================================
-- 13. Coal liquefaction - remove research completely
--     (replaced by coal-liquefaction recipe unlocked via asteroid-reprocessing)
-- ============================================================
data.raw["technology"]["coal-liquefaction"] = nil


-- ============================================================
-- 14. Burnt spoilage recipe - 15 nutrients + 1 spoilage → 2 carbon
-- ============================================================
local burnt_spoilage = data.raw["recipe"]["burnt-spoilage"]
if burnt_spoilage then
    burnt_spoilage.energy_required = 2
    burnt_spoilage.ingredients = {
        {type = "item", name = "nutrients", amount = 15},
        {type = "item", name = "spoilage",  amount = 1},
    }
    burnt_spoilage.results = {
        {type = "item", name = "carbon", amount = 2},
    }
end
