-- Complex Space Age science packs
-- By ThreeTimesWell



-- Space science

if data.raw.recipe["space-science-pack"] then
  data.raw.recipe["space-science-pack"].ingredients = {
    {type = "item", name = "carbon",      amount = 1},
    {type = "item", name = "ice",         amount = 1},
    {type = "item", name = "iron-plate",  amount = 2},
    {type = "item", name = "uranium-235", amount = 1},
  }
  data.raw.recipe["space-science-pack"].results = {
    {type = "item", name = "space-science-pack", amount = 5},
    {type = "item", name = "uranium-235",        amount = 1, probability = 0.5},
  }
  local space_extras = {
    {type = "item", name = "automation-science-pack", amount = 1},
    {type = "item", name = "logistic-science-pack",   amount = 1},
    {type = "item", name = "military-science-pack",   amount = 1},
    {type = "item", name = "chemical-science-pack",   amount = 1},
    {type = "item", name = "production-science-pack", amount = 1},
    {type = "item", name = "utility-science-pack",    amount = 1},
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

-- Advanced carbonic asteroid crushing - increase carbon output from 5 to 10

if data.raw["recipe"]["advanced-carbonic-asteroid-crushing"] then
  if data.raw["recipe"]["advanced-carbonic-asteroid-crushing"].results then
    for _, result in pairs(data.raw["recipe"]["advanced-carbonic-asteroid-crushing"].results) do
      if result.name == "carbon" then
        result.amount = 8
      end
      if result.name == "sulfur" then
        result.amount = 4
      end
    end
  end
end

-- Coal synthesis - decrease carbon input from 5 to 2

if data.raw["recipe"]["coal-synthesis"] then
  if data.raw["recipe"]["coal-synthesis"].ingredients then
    for _, ingredient in pairs(data.raw["recipe"]["coal-synthesis"].ingredients) do
      if ingredient.name == "carbon" then
        ingredient.amount = 3
      end
    end
  end
end