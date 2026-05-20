-- =============================================================
-- Metallurgic science pack platform drag correction
--
-- Applies extra drag to space platforms carrying metallurgic
-- science packs, simulating their weight contribution to
-- platform drag. Only active when Rocs-Improved-Platform-Drag
-- is installed (which replaces vanilla width-based drag with
-- sqrt(weight)-based drag).
--
-- The correction mimics the Rocs formula drag term:
--   drag_force = (1500*v^2 + 1500*|v|) * (sqrt(w/177.24) * 0.5)
-- Extra drag = same term computed with (w + extra_w) minus with w.
-- Applied as a per-tick speed reduction. Does NOT affect rocket
-- capacity — that is controlled by ga-metallurgic-weight.
-- =============================================================

-- Rocs constants (must match Rocs-Improved-Platform-Drag_1.1.5)
local TILE_WEIGHT_KG = 200      -- kg per foundation tile
local SHAPE_CONST    = 0.8862   -- (pi/4)^0.5, circular platform assumption
local DRAG_DENOM     = TILE_WEIGHT_KG * SHAPE_CONST  -- 177.24

-- Debug: print to game console every N ticks (300 = ~5 s). Set to 0 to disable.
local LOG_INTERVAL   = 300

-- Cached at load time (startup settings never change mid-game)
local rocs_active       = false
local drag_weight_kg    = 50000  -- default, overwritten on load

local function cache_settings()
    rocs_active    = (script.active_mods["Rocs-Improved-Platform-Drag"] ~= nil)
    drag_weight_kg = settings.startup["ga-metallurgic-platform-drag-weight"].value
end

script.on_init(function()
    cache_settings()
    game.print("[MetalDrag] on_init: Rocs=" .. tostring(rocs_active) ..
               "  drag_weight=" .. drag_weight_kg)
end)
script.on_load(cache_settings)

-- ---------------------------------------------------------------------------
-- Per-tick drag correction
-- ---------------------------------------------------------------------------
local function on_tick()
    local logging = LOG_INTERVAL > 0 and game.tick % LOG_INTERVAL == 0

    if not rocs_active then
        if logging then
            game.print("[MetalDrag] Rocs not detected – drag correction disabled.")
        end
        return
    end

    for _, force in pairs(game.forces) do
        for _, platform in pairs(force.platforms) do
            if not platform.valid then goto continue_platform end

            local v = platform.speed
            if v == 0 then goto continue_platform end

            local hub = platform.hub
            if not hub or not hub.valid then goto continue_platform end

            local inv = hub.get_inventory(defines.inventory.hub_main)
            local pack_count = inv and inv.get_item_count("metallurgic-science-pack") or 0

            if logging then
                game.print(string.format(
                    "[MetalDrag] '%s': inv=%s  packs=%d  speed=%.4f  weight=%.0f",
                    platform.name, tostring(inv ~= nil), pack_count, v, platform.weight))
            end

            if pack_count == 0 then goto continue_platform end

            local w_kg = platform.weight
            if w_kg <= 0 then goto continue_platform end

            local extra_w_kg  = pack_count * drag_weight_kg
            local total_w_kg  = w_kg + extra_w_kg

            local abs_v         = math.abs(v)
            local sign_v        = (v > 0) and 1 or -1
            local eff_w_base    = math.sqrt(w_kg      / DRAG_DENOM)
            local eff_w_total   = math.sqrt(total_w_kg / DRAG_DENOM)
            local delta_eff_w   = eff_w_total - eff_w_base

            local extra_drag    = (1500 * v * v + 1500 * abs_v) * 0.5 * delta_eff_w
            -- Divide by w_kg (base weight), not total_w_kg: packs add drag area but
            -- their inertia is already borne by the hub structure (which is in w_kg).
            -- Using total_w_kg would cancel most of the effect via the mass denominator.
            local correction    = extra_drag * sign_v / w_kg / 60

            platform.speed = v - correction

            if logging then
                game.print(string.format(
                    "[MetalDrag]   -> correction=%.6f  new_speed=%.4f",
                    correction, platform.speed))
            end

            ::continue_platform::
        end
    end
end

script.on_event(defines.events.on_tick, on_tick)
