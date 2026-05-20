require("prototypes.recipe")

if settings.startup["ga-biolabs-require-nutrients"].value == true
then
    data.raw["lab"]["biolab"].energy_source = { type = "burner", fuel_categories = { "nutrients" }, effectivity = 1, burner_usage = "nutrients", fuel_inventory_size = 1, emissions_per_minute = { pollution = 8 } }
    data.raw["lab"]["biolab"].energy_usage = settings.startup["ga-biolabs-energy-consumption"].value .. "kW"
end