
-- NaerCounter  –  GuideData.lua
-- Structured leveling guide data for Herbalism & Mining (1-450)
-- Classic (1-300) + TBC Outland (300-375) + WotLK Northrend (375-450)
-- WotLK 3.3.5a 30300 esMX - Naerzone Edition

local _, NS = ...

NS.GuideData = {
    herbs = {

        -- Classic  (1-300)

        {
            skillRange = {1, 70},
            label = "1 - 70",
            resources = { "Peacebloom", "Silverleaf", "Earthroot" },
            zones = {
                { zone = "Durotar",          faction = "horde" },
                { zone = "Mulgore",          faction = "horde" },
                { zone = "Tirisfal Glades",  faction = "horde" },
                { zone = "Elwynn Forest",    faction = "alliance" },
                { zone = "Dun Morogh",       faction = "alliance" },
                { zone = "Teldrassil",       faction = "alliance" },
            },
            tip = "¡Aprende Oficial a 50! |cFF00CCFFNaerzone|r: Orgrimmar / Ventormenta",
        },
        {
            skillRange = {70, 115},
            label = "70 - 115",
            resources = { "Mageroyal", "Briarthorn", "Stranglekelp" },
            zones = {
                { zone = "The Barrens",       faction = "horde" },
                { zone = "Silverpine Forest", faction = "horde" },
                { zone = "Darkshore",         faction = "alliance" },
                { zone = "Loch Modan",        faction = "alliance" },
            },
        },
        {
            skillRange = {115, 170},
            label = "115 - 170",
            resources = { "Bruiseweed", "Wild Steelbloom", "Kingsblood", "Liferoot" },
            zones = {
                { zone = "Hillsbrad Foothills", faction = "both" },
                { zone = "Wetlands",            faction = "alliance" },
                { zone = "Stonetalon Mountains",faction = "both" },
            },
            tip = "¡Aprende Experto a 125!",
        },
        {
            skillRange = {170, 205},
            label = "170 - 205",
            resources = { "Kingsblood", "Liferoot", "Fadeleaf", "Goldthorn", "Khadgar's Whisker" },
            zones = {
                { zone = "Stranglethorn Vale", faction = "both" },
                { zone = "Arathi Highlands",   faction = "both" },
            },
            tip = "¡Aprende Artesano a 200!",
        },
        {
            skillRange = {205, 230},
            label = "205 - 230",
            resources = { "Purple Lotus", "Firebloom" },
            zones = {
                { zone = "Tanaris",        faction = "both" },
                { zone = "Searing Gorge",  faction = "both" },
            },
        },
        {
            skillRange = {230, 270},
            label = "230 - 270",
            resources = { "Sungrass", "Purple Lotus", "Ghost Mushroom", "Golden Sansam" },
            zones = {
                { zone = "The Hinterlands", faction = "both" },
            },
        },
        {
            skillRange = {270, 300},
            label = "270 - 300",
            resources = { "Sungrass", "Gromsblood", "Golden Sansam", "Dreamfoil", "Mountain Silversage", "Plaguebloom" },
            zones = {
                { zone = "Felwood", faction = "both" },
                { zone = "Un'Goro Crater", faction = "both" },
                { zone = "Azshara", faction = "both" },
            },
            tip = "¡Maestro a 275! Ve a Outland",
        },

        -- TBC Outland  (300-375)

        {
            skillRange = {300, 315},
            label = "300 - 315",
            resources = { "Felweed", "Dreaming Glory" },
            zones = {
                { zone = "Hellfire Peninsula", faction = "both" },
            },
            tip = "Horda: Ruak Stronghorn (Thrallmar) / Alianza: Rorelien (Honor Hold)",
        },
        {
            skillRange = {315, 325},
            label = "315 - 325",
            resources = { "Felweed", "Dreaming Glory" },
            zones = {
                { zone = "Nagrand",                faction = "both" },
                { zone = "Blade's Edge Mountains", faction = "both" },
            },
        },
        {
            skillRange = {325, 350},
            label = "325 - 350",
            resources = { "Felweed", "Dreaming Glory", "Terocone" },
            zones = {
                { zone = "Terokkar Forest", faction = "both" },
            },
        },
        {
            skillRange = {350, 375},
            label = "350 - 375",
            resources = { "Netherbloom", "Nightmare Vine", "Mana Thistle" },
            zones = {
                { zone = "Netherstorm", faction = "both" },
                { zone = "Shadowmoon Valley", faction = "both" },
            },
            tip = "¡Prepara WotLK! 350-375 en Tormenta Abisal",
        },

        -- WotLK Northrend  (375-450) - NUEVO NAERZONE

        {
            skillRange = {375, 400},
            label = "375 - 400",
            resources = { "Goldclover", "Tiger Lily" },
            zones = {
                { zone = "Howling Fjord",  faction = "both" },
                { zone = "Borean Tundra",  faction = "both" },
            },
            tip = "Maestro de Reclutas 375: Dalaran - Herboristeria",
        },
        {
            skillRange = {400, 425},
            label = "400 - 425",
            resources = { "Goldclover", "Tiger Lily", "Adder's Tongue", "Deadnettle" },
            zones = {
                { zone = "Dragonblight", faction = "both" },
                { zone = "Grizzly Hills", faction = "both" },
            },
        },
        {
            skillRange = {425, 450},
            label = "425 - 450",
            resources = { "Adder's Tongue", "Talandra's Rose", "Lichbloom", "Icethorn", "Frost Lotus" },
            zones = {
                { zone = "Sholazar Basin",  faction = "both" },
                { zone = "The Storm Peaks", faction = "both" },
                { zone = "Icecrown",        faction = "both" },
                { zone = "Wintergrasp",     faction = "both" },
                { zone = "Zul'Drak",        faction = "both" },
            },
            tip = "¡Gran Maestro 450! Cuenca de Sholazar = Frost Lotus",
        },
    },

    mining = {

        -- Classic  (1-300)

        {
            skillRange = {1, 65},
            label = "1 - 65",
            resources = { "Copper Ore" },
            zones = {
                { zone = "Durotar",          faction = "horde" },
                { zone = "Mulgore",          faction = "horde" },
                { zone = "Tirisfal Glades",  faction = "horde" },
                { zone = "Elwynn Forest",    faction = "alliance" },
                { zone = "Dun Morogh",       faction = "alliance" },
                { zone = "Darkshore",        faction = "alliance" },
            },
            tip = "¡Oficial a 50!",
        },
        {
            skillRange = {65, 125},
            label = "65 - 125",
            resources = { "Tin Ore", "Silver Ore" },
            zones = {
                { zone = "The Barrens",         faction = "horde" },
                { zone = "Hillsbrad Foothills", faction = "both" },
                { zone = "Redridge Mountains",  faction = "alliance" },
                { zone = "Ashenvale",           faction = "both" },
            },
            tip = "¡Experto a 125!",
        },
        {
            skillRange = {125, 175},
            label = "125 - 175",
            resources = { "Iron Ore", "Gold Ore" },
            zones = {
                { zone = "Arathi Highlands",  faction = "both" },
                { zone = "Desolace",          faction = "both" },
                { zone = "Thousand Needles",  faction = "both" },
            },
        },
        {
            skillRange = {175, 245},
            label = "175 - 245",
            resources = { "Mithril Ore", "Truesilver Ore" },
            zones = {
                { zone = "The Hinterlands", faction = "both" },
                { zone = "Tanaris",         faction = "both" },
            },
            tip = "¡Artesano a 200!",
        },
        {
            skillRange = {245, 275},
            label = "245 - 275",
            resources = { "Mithril Ore", "Truesilver Ore", "Thorium Ore" },
            zones = {
                { zone = "Un'Goro Crater",  faction = "both" },
                { zone = "Blasted Lands",   faction = "both" },
                { zone = "Felwood",         faction = "both" },
            },
            tip = "¡Maestro a 275!",
        },
        {
            skillRange = {275, 300},
            label = "275 - 300",
            resources = { "Thorium Ore", "Rich Thorium Vein" },
            zones = {
                { zone = "Un'Goro Crater",      faction = "both" },
                { zone = "Eastern Plaguelands",  faction = "both" },
                { zone = "Winterspring",         faction = "both" },
                { zone = "Burning Steppes",      faction = "both" },
            },
        },

        -- TBC Outland  (300-375)

        {
            skillRange = {300, 325},
            label = "300 - 325",
            resources = { "Fel Iron Ore" },
            zones = {
                { zone = "Hellfire Peninsula", faction = "both" },
            },
            tip = "Horda: Krugosh (Thrallmar) / Alianza: Hurnak Grimmord",
        },
        {
            skillRange = {325, 350},
            label = "325 - 350",
            resources = { "Adamantite Ore" },
            zones = {
                { zone = "Zangarmarsh",     faction = "both" },
                { zone = "Terokkar Forest", faction = "both" },
            },
        },
        {
            skillRange = {350, 375},
            label = "350 - 375",
            resources = { "Rich Adamantite Ore", "Khorium Ore" },
            zones = {
                { zone = "Nagrand",             faction = "both" },
                { zone = "Netherstorm",         faction = "both" },
                { zone = "Shadowmoon Valley",   faction = "both" },
            },
        },

        -- WotLK Northrend  (375-450) - NUEVO NAERZONE

        {
            skillRange = {375, 400},
            label = "375 - 400",
            resources = { "Cobalt Ore" },
            zones = {
                { zone = "Howling Fjord",  faction = "both" },
                { zone = "Borean Tundra",  faction = "both" },
            },
            tip = "Gran Maestro Mineria 375: Dalaran",
        },
        {
            skillRange = {400, 425},
            label = "400 - 425",
            resources = { "Cobalt Ore", "Saronite Ore" },
            zones = {
                { zone = "Dragonblight", faction = "both" },
                { zone = "Grizzly Hills", faction = "both" },
                { zone = "Zul'Drak", faction = "both" },
            },
        },
        {
            skillRange = {425, 450},
            label = "425 - 450",
            resources = { "Saronite Ore", "Rich Saronite Ore", "Titanium Ore", "Titanium Vein" },
            zones = {
                { zone = "Sholazar Basin",  faction = "both" },
                { zone = "The Storm Peaks", faction = "both" },
                { zone = "Icecrown",        faction = "both" },
                { zone = "Wintergrasp",     faction = "both" },
            },
            tip = "450: Cumbres Tormentosas = Titanio + Saronita Titánica",
        },
    },
}

-- Training thresholds - WotLK 1-450

NS.GuideTraining = {
    { skill = 50,  rank = "Oficial",      cap = 75,  label = "Oficial" },
    { skill = 125, rank = "Experto",      cap = 150, label = "Experto" },
    { skill = 200, rank = "Artesano",     cap = 225, label = "Artesano" },
    { skill = 275, rank = "Maestro",      cap = 300, label = "Maestro" },
    { skill = 350, rank = "Gran Maestro", cap = 375, label = "Gran Maestro TBC" },
    { skill = 400, rank = "Gran Maestro", cap = 450, label = "Gran Maestro WotLK" },
}
