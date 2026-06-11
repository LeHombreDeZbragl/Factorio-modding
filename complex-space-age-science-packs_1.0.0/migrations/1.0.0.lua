-- Remove coal resource patches from Gleba (coal gen was removed in 1.0.1)
local removed = 0
for _, surface in pairs(game.surfaces) do
    if surface.name == "gleba" then
        local coal_entities = surface.find_entities_filtered{
            type = "resource",
            name = "coal",
        }
        for _, entity in pairs(coal_entities) do
            if entity.valid then
                entity.destroy()
                removed = removed + 1
            end
        end
    end
end
game.print("[Complex Science Packs] Removed " .. removed .. " coal patches from Gleba.")
