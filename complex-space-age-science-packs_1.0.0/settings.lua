data:extend({
    {
        type = "bool-setting",
        name = "ga-biolabs-require-nutrients",
        setting_type = "startup",
        default_value = true
    },
    {
        type = "int-setting",
        name = "ga-biolabs-energy-consumption",
        setting_type = "startup",
        default_value = 1000,
        minimum_value = 1
    },
    {
        type = "int-setting",
        name = "ga-metallurgic-weight",
        setting_type = "startup",
        default_value = 5,
        minimum_value = 1,
        maximum_value = 1000,
        order = "c"
    },
    {
        type = "int-setting",
        name = "ga-metallurgic-platform-drag-weight",
        setting_type = "startup",
        default_value = 5000,
        minimum_value = 1,
        maximum_value = 100000,
        order = "d"
    }
})