-- Complex Space Age science packs
-- By ThreeTimesWell

-- Space science

if data.raw.recipe["space-science-pack"] then
  local space_extras = {
    {type = "item", name = "automation-science-pack", amount = 1},
    {type = "item", name = "logistic-science-pack",   amount = 1},
    {type = "item", name = "chemical-science-pack",   amount = 1},
    {type = "item", name = "military-science-pack",   amount = 1},
  }
  for _, item in pairs(space_extras) do
    table.insert(data.raw.recipe["space-science-pack"].ingredients, item)
  end
end

-- Metallurgic science

if data.raw["recipe"]["metallurgic-science-pack"] then
  local metallurgic_extras = {
    {type = "item", name = "automation-science-pack", amount = 1},
    {type = "item", name = "logistic-science-pack",   amount = 1},
    {type = "item", name = "military-science-pack",   amount = 1},
    {type = "item", name = "chemical-science-pack",   amount = 1},
    {type = "item", name = "production-science-pack", amount = 1},
    {type = "item", name = "utility-science-pack",    amount = 1},
  }
  for _, item in pairs(metallurgic_extras) do
    table.insert(data.raw["recipe"]["metallurgic-science-pack"].ingredients, item)
  end
end

-- Agricultural science

if data.raw["recipe"]["agricultural-science-pack"] then
  local agricultural_extras = {
    {type = "item", name = "automation-science-pack", amount = 1},
    {type = "item", name = "logistic-science-pack",   amount = 1},
    {type = "item", name = "military-science-pack",   amount = 1},
    {type = "item", name = "chemical-science-pack",   amount = 1},
    {type = "item", name = "production-science-pack", amount = 1},
    {type = "item", name = "utility-science-pack",    amount = 1},
  }
  for _, item in pairs(agricultural_extras) do
    table.insert(data.raw["recipe"]["agricultural-science-pack"].ingredients, item)
  end
end

-- Electromagnetic science

if not mods["harder-pack"] then
  if data.raw["recipe"]["electromagnetic-science-pack"] then
    local em_extras = {
      {type = "item", name = "automation-science-pack", amount = 1},
      {type = "item", name = "logistic-science-pack",   amount = 1},
      {type = "item", name = "military-science-pack",   amount = 1},
      {type = "item", name = "chemical-science-pack",   amount = 1},
      {type = "item", name = "production-science-pack", amount = 1},
      {type = "item", name = "utility-science-pack",    amount = 1},
    }
    for _, item in pairs(em_extras) do
      table.insert(data.raw["recipe"]["electromagnetic-science-pack"].ingredients, item)
    end
  end
end

if mods["harder-pack"] then
  if data.raw["recipe"]["low-charge-electromagnetic-science-pack"] then
    local em_extras = {
      {type = "item", name = "automation-science-pack", amount = 1},
      {type = "item", name = "logistic-science-pack",   amount = 1},
      {type = "item", name = "military-science-pack",   amount = 1},
      {type = "item", name = "chemical-science-pack",   amount = 1},
      {type = "item", name = "production-science-pack", amount = 1},
      {type = "item", name = "utility-science-pack",    amount = 1},
    }
    for _, item in pairs(em_extras) do
      table.insert(data.raw["recipe"]["low-charge-electromagnetic-science-pack"].ingredients, item)
    end
  end
end

-- Cryogenic science

if data.raw["recipe"]["cryogenic-science-pack"] then
  local cryo_extras = {
    {type = "item", name = "automation-science-pack", amount = 1},
    {type = "item", name = "logistic-science-pack",   amount = 1},
    {type = "item", name = "military-science-pack",   amount = 1},
    {type = "item", name = "chemical-science-pack",   amount = 1},
    {type = "item", name = "production-science-pack", amount = 1},
    {type = "item", name = "utility-science-pack",    amount = 1},
  }
  for _, item in pairs(cryo_extras) do
    table.insert(data.raw["recipe"]["cryogenic-science-pack"].ingredients, item)
  end
end