
-- NaerCounter  -  FarmingData.lua
-- Farming routes per resource: herbs & ores + gases + WotLK 375-450
-- WotLK 3.3.5a 30300 esMX - Naerzone Edition

local _, NS = ...

local TEX = "Interface\\AddOns\\NaerCounter\\textures\\farming\\"

NS.FarmingData = {

    -- CLASSIC HERBS

    {
        name = "Peacebloom / Silverleaf",
        type = "herbs",
        skillRange = "1-70",
        zones = {
            { zone = "Tirisfal Glades", texture = TEX .. "peacebloom-silverleaf-tirisfal-glades" },
            { zone = "Elwynn Forest",   texture = TEX .. "peacebloom-silverleaf-elwynn-forest" },
            { zone = "Durotar",         texture = TEX .. "peacebloom-silverleaf-durotar" },
            { zone = "Dun Morogh",      texture = TEX .. "peacebloom-silverleaf-dun-morogh" },
            { zone = "Teldrassil",      texture = TEX .. "peacebloom-silverleaf-teldrassil" },
            { zone = "Mulgore",         texture = TEX .. "peacebloom-silverleaf-mulgore" },
            { zone = "Eversong Woods",  texture = TEX .. "peacebloom-silverleaf-eversong" },
            { zone = "Azuremyst Isle",  texture = TEX .. "peacebloom-silverleaf-azuremyst" },
        },
    },
    {
        name = "Briarthorn / Mageroyal",
        type = "herbs",
        skillRange = "50-100",
        zones = {
            { zone = "Hillsbrad Foothills", texture = TEX .. "briarthorn-mageroyal-hillsbrad" },
            { zone = "Darkshore",           texture = TEX .. "briarthorn-mageroyal-darkshore" },
            { zone = "The Barrens",         texture = TEX .. "briarthorn-mageroyal-barrens" },
        },
    },
    {
        name = "Stranglekelp",
        type = "herbs",
        skillRange = "85-135",
        zones = {
            { zone = "Wetlands", texture = TEX .. "stranglekelp-wetlands" },
            { zone = "Darkshore", texture = TEX .. "stranglekelp-darkshore" },
        },
    },
    {
        name = "Bruiseweed",
        type = "herbs",
        skillRange = "100-150",
        zones = {
            { zone = "Stranglethorn Vale", texture = TEX .. "bruiseweed-stv" },
            { zone = "Ashenvale",          texture = TEX .. "bruiseweed-ashenvale" },
            { zone = "Wetlands",           texture = TEX .. "bruiseweed-wetlands" },
        },
    },
    {
        name = "Wild Steelbloom",
        type = "herbs",
        skillRange = "115-170",
        zones = {
            { zone = "Stranglethorn Vale", texture = TEX .. "wild-steelbloom-stv" },
            { zone = "Ashenvale",          texture = TEX .. "wild-steelbloom-ashenvale" },
        },
    },
    {
        name = "Grave Moss",
        type = "herbs",
        skillRange = "120-170",
        zones = {
            { zone = "Hillsbrad Foothills", texture = TEX .. "grave-moss-hillsbrad" },
            { zone = "Arathi Highlands",    texture = TEX .. "grave-moss-arathi" },
            { zone = "Wetlands",            texture = TEX .. "grave-moss-wetlands" },
            { zone = "Duskwood",            texture = TEX .. "grave-moss-duskwood" },
        },
    },
    {
        name = "Kingsblood",
        type = "herbs",
        skillRange = "125-175",
        zones = {
            { zone = "Stranglethorn Vale",  texture = TEX .. "kingsblood-stv" },
            { zone = "Western Plaguelands", texture = TEX .. "kingsblood-wpl" },
        },
    },
    {
        name = "Liferoot",
        type = "herbs",
        skillRange = "150-205",
        zones = {
            { zone = "Western Plaguelands", texture = TEX .. "liferoot-wpl" },
            { zone = "Eastern Plaguelands", texture = TEX .. "liferoot-epl" },
            { zone = "Stranglethorn Vale",  texture = TEX .. "liferoot-northern-stranglethorn" },
        },
    },
    {
        name = "Fadeleaf",
        type = "herbs",
        skillRange = "150-205",
        zones = {
            { zone = "Feralas",            texture = TEX .. "fadeleaf-feralas" },
            { zone = "Stranglethorn Vale", texture = TEX .. "fadeleaf-stv" },
        },
    },
    {
        name = "Goldthorn",
        type = "herbs",
        skillRange = "150-220",
        zones = {
            { zone = "The Hinterlands",    texture = TEX .. "goldthorn-hinterlands" },
            { zone = "Arathi Highlands",   texture = TEX .. "goldthorn-arathi" },
            { zone = "Dustwallow Marsh",   texture = TEX .. "goldthorn-dustwallow" },
        },
    },
    {
        name = "Khadgar's Whisker",
        type = "herbs",
        skillRange = "160-220",
        zones = {
            { zone = "Eastern Plaguelands",  texture = TEX .. "khadgars-whisker-eastern-plaguelands" },
            { zone = "Western Plaguelands",  texture = TEX .. "khadgars-whisker-western-plaguelands" },
        },
    },
    {
        name = "Firebloom",
        type = "herbs",
        skillRange = "205-255",
        zones = {
            { zone = "Burning Steppes", texture = TEX .. "firebloom-burning-steppes" },
            { zone = "Searing Gorge",   texture = TEX .. "firebloom-searing-gorge" },
            { zone = "Tanaris",         texture = TEX .. "firebloom-tanaris" },
        },
    },
    {
        name = "Sungrass",
        type = "herbs",
        skillRange = "230-270",
        zones = {
            { zone = "Thousand Needles",    texture = TEX .. "sungrass-thousand-needles" },
            { zone = "Eastern Plaguelands", texture = TEX .. "sungrass-eastern-plaguelands" },
            { zone = "Felwood",             texture = TEX .. "sungrass-felwood" },
        },
    },
    {
        name = "Purple Lotus",
        type = "herbs",
        skillRange = "210-250",
        zones = {
            { zone = "Felwood", texture = TEX .. "purple-lotus-felwood" },
        },
    },
    {
        name = "Blindweed",
        type = "herbs",
        skillRange = "235-275",
        zones = {
            { zone = "Feralas",             texture = TEX .. "blindweed-feralas" },
            { zone = "Western Plaguelands", texture = TEX .. "blindweed-western-plaguelands" },
        },
    },
    {
        name = "Ghost Mushroom",
        type = "herbs",
        skillRange = "245-275",
        zones = {
            { zone = "Un'Goro Crater", texture = TEX .. "ghost-mushroom-ungoro" },
            { zone = "Zangarmarsh",    texture = TEX .. "ghost-mushroom-zangarmarsh" },
        },
    },
    {
        name = "Gromsblood",
        type = "herbs",
        skillRange = "250-280",
        zones = {
            { zone = "Felwood", texture = TEX .. "gromsblood-felwood" },
            { zone = "Blasted Lands", texture = TEX .. "gromsblood-blasted" },
        },
    },
    {
        name = "Golden Sansam",
        type = "herbs",
        skillRange = "260-300",
        zones = {
            { zone = "Swamp of Sorrows", texture = TEX .. "golden-sansam-swamp" },
            { zone = "Felwood",          texture = TEX .. "golden-sansam-felwood" },
            { zone = "Un'Goro Crater",   texture = TEX .. "golden-sansam-ungoro" },
        },
    },
    {
        name = "Dreamfoil",
        type = "herbs",
        skillRange = "270-300",
        zones = {
            { zone = "Blasted Lands", texture = TEX .. "dreamfoil-blasted-lands" },
            { zone = "Silithus",      texture = TEX .. "dreamfoil-silithus" },
            { zone = "Azshara",       texture = TEX .. "dreamfoil-azshara" },
        },
    },
    {
        name = "Mountain Silversage",
        type = "herbs",
        skillRange = "280-300",
        zones = {
            { zone = "Winterspring", texture = TEX .. "mountain-silversage-winterspring" },
            { zone = "Eastern Plaguelands", texture = TEX .. "mountain-silversage-epl" },
        },
    },
    {
        name = "Icecap",
        type = "herbs",
        skillRange = "290-300",
        zones = {
            { zone = "Winterspring", texture = TEX .. "icecap-winterspring" },
        },
    },
    {
        name = "Sorrowmoss",
        type = "herbs",
        skillRange = "285-300",
        zones = {
            { zone = "Swamp of Sorrows", texture = TEX .. "sorrowmoss-swamp-of-sorrows" },
        },
    },

    -- TBC HERBS 300-375

    {
        name = "Felweed",
        type = "herbs",
        skillRange = "300-325",
        zones = {
            { zone = "Hellfire Peninsula", texture = TEX .. "felweed-hellfire" },
            { zone = "Blade's Edge Mountains", texture = TEX .. "felweed-blades-edge" },
            { zone = "Nagrand",                texture = TEX .. "felweed-nagrand" },
        },
    },
    {
        name = "Dreaming Glory",
        type = "herbs",
        skillRange = "315-350",
        zones = {
            { zone = "Blade's Edge Mountains", texture = TEX .. "dreaming-glory-blades-edge" },
            { zone = "Nagrand",                texture = TEX .. "dreaming-glory-nagrand" },
            { zone = "Terokkar Forest",        texture = TEX .. "dreaming-glory-terokkar" },
        },
    },
    {
        name = "Terocone",
        type = "herbs",
        skillRange = "325-350",
        zones = {
            { zone = "Terokkar Forest", texture = TEX .. "terocone-terokkar" },
        },
    },
    {
        name = "Ragveil",
        type = "herbs",
        skillRange = "325-350",
        zones = {
            { zone = "Zangarmarsh", texture = TEX .. "ragveil-zangarmarsh" },
        },
    },
    {
        name = "Flame Cap",
        type = "herbs",
        skillRange = "335-365",
        zones = {
            { zone = "Zangarmarsh", texture = TEX .. "flame-cap-zangarmarsh" },
        },
    },
    {
        name = "Nightmare Vine",
        type = "herbs",
        skillRange = "365-375",
        zones = {
            { zone = "Shadowmoon Valley", texture = TEX .. "nightmare-vine-shadowmoon" },
            { zone = "Blade's Edge Mountains", texture = TEX .. "nightmare-vine-blades-edge" },
        },
    },
    {
        name = "Netherbloom",
        type = "herbs",
        skillRange = "350-375",
        zones = {
            { zone = "Netherstorm", texture = TEX .. "netherbloom-netherstorm" },
        },
    },
    {
        name = "Mana Thistle",
        type = "herbs",
        skillRange = "360-375",
        zones = {
            { zone = "Netherstorm", texture = TEX .. "mana-thistle-netherstorm" },
            { zone = "Shadowmoon Valley", texture = TEX .. "mana-thistle-shadowmoon" },
        },
    },

    -- WOTLK HERBS 375-450 - NUEVO PARA NAERZONE

    {
        name = "Goldclover",
        type = "herbs",
        skillRange = "375-400",
        zones = {
            { zone = "Howling Fjord",  texture = TEX .. "goldclover-howling-fjord" },
            { zone = "Borean Tundra",  texture = TEX .. "goldclover-borean-tundra" },
            { zone = "Dragonblight",   texture = TEX .. "goldclover-dragonblight" },
            { zone = "Grizzly Hills",  texture = TEX .. "goldclover-grizzly" },
        },
    },
    {
        name = "Tiger Lily",
        type = "herbs",
        skillRange = "375-425",
        zones = {
            { zone = "Howling Fjord",  texture = TEX .. "tiger-lily-howling-fjord" },
            { zone = "Borean Tundra",  texture = TEX .. "tiger-lily-borean-tundra" },
            { zone = "Dragonblight",   texture = TEX .. "tiger-lily-dragonblight" },
            { zone = "Grizzly Hills",  texture = TEX .. "tiger-lily-grizzly" },
            { zone = "Sholazar Basin", texture = TEX .. "tiger-lily-sholazar" },
        },
    },
    {
        name = "Adder's Tongue",
        type = "herbs",
        skillRange = "400-450",
        zones = {
            { zone = "Dragonblight",   texture = TEX .. "adders-tongue-dragonblight" },
            { zone = "Grizzly Hills",  texture = TEX .. "adders-tongue-grizzly" },
            { zone = "Sholazar Basin", texture = TEX .. "adders-tongue-sholazar" },
            { zone = "Zul'Drak",       texture = TEX .. "adders-tongue-zuldrak" },
        },
    },
    {
        name = "Talandra's Rose",
        type = "herbs",
        skillRange = "400-430",
        zones = {
            { zone = "Zul'Drak",       texture = TEX .. "talandras-rose-zuldrak" },
            { zone = "Dragonblight",   texture = TEX .. "talandras-rose-dragonblight" },
        },
    },
    {
        name = "Lichbloom",
        type = "herbs",
        skillRange = "425-450",
        zones = {
            { zone = "Howling Fjord",  texture = TEX .. "lichbloom-howling" },
            { zone = "Dragonblight",   texture = TEX .. "lichbloom-dragonblight" },
            { zone = "Grizzly Hills",  texture = TEX .. "lichbloom-grizzly" },
            { zone = "Zul'Drak",       texture = TEX .. "lichbloom-zuldrak" },
            { zone = "Sholazar Basin", texture = TEX .. "lichbloom-sholazar" },
            { zone = "The Storm Peaks",texture = TEX .. "lichbloom-storm-peaks" },
            { zone = "Icecrown",       texture = TEX .. "lichbloom-icecrown" },
        },
    },
    {
        name = "Icethorn",
        type = "herbs",
        skillRange = "425-450",
        zones = {
            { zone = "Dragonblight",   texture = TEX .. "icethorn-dragonblight" },
            { zone = "Grizzly Hills",  texture = TEX .. "icethorn-grizzly" },
            { zone = "Zul'Drak",       texture = TEX .. "icethorn-zuldrak" },
            { zone = "Sholazar Basin", texture = TEX .. "icethorn-sholazar" },
            { zone = "The Storm Peaks",texture = TEX .. "icethorn-storm-peaks" },
            { zone = "Icecrown",       texture = TEX .. "icethorn-icecrown" },
        },
    },
    {
        name = "Frost Lotus",
        type = "herbs",
        skillRange = "425-450",
        zones = {
            { zone = "Wintergrasp",    texture = TEX .. "frost-lotus-wintergrasp" },
            { zone = "The Storm Peaks",texture = TEX .. "frost-lotus-storm-peaks" },
            { zone = "Icecrown",       texture = TEX .. "frost-lotus-icecrown" },
            { zone = "Sholazar Basin", texture = TEX .. "frost-lotus-sholazar" },
        },
    },

    -- CLASSIC ORES

    {
        name = "Copper Ore",
        type = "mining",
        skillRange = "1-65",
        zones = {
            { zone = "Durotar",   texture = TEX .. "copper-ore-durotar" },
            { zone = "Darkshore", texture = TEX .. "copper-ore-darkshore" },
            { zone = "Elwynn Forest", texture = TEX .. "copper-ore-elwynn" },
            { zone = "Dun Morogh", texture = TEX .. "copper-ore-dun-morogh" },
            { zone = "Eversong Woods", texture = TEX .. "copper-ore-eversong" },
        },
    },
    {
        name = "Tin Ore",
        type = "mining",
        skillRange = "50-125",
        zones = {
            { zone = "Hillsbrad Foothills",  texture = TEX .. "tin-ore-hillsbrad" },
            { zone = "Stranglethorn Vale",   texture = TEX .. "tin-ore-stranglethorn" },
            { zone = "The Barrens",          texture = TEX .. "tin-ore-barrens" },
        },
    },
    {
        name = "Iron Ore",
        type = "mining",
        skillRange = "100-175",
        zones = {
            { zone = "Feralas",             texture = TEX .. "iron-ore-feralas" },
            { zone = "Western Plaguelands", texture = TEX .. "iron-ore-wpl" },
            { zone = "Arathi Highlands",    texture = TEX .. "iron-ore-arathi" },
        },
    },
    {
        name = "Mithril Ore",
        type = "mining",
        skillRange = "150-250",
        zones = {
            { zone = "Burning Steppes", texture = TEX .. "mithril-ore-burning-steppes" },
            { zone = "Badlands",        texture = TEX .. "mithril-ore-badlands" },
            { zone = "Felwood",         texture = TEX .. "mithril-ore-felwood" },
            { zone = "Tanaris",         texture = TEX .. "mithril-ore-tanaris" },
        },
    },
    {
        name = "Thorium Ore",
        type = "mining",
        skillRange = "200-300",
        zones = {
            { zone = "Winterspring",    texture = TEX .. "thorium-ore-winterspring" },
            { zone = "Un'Goro Crater",  texture = TEX .. "thorium-ore-ungoro" },
            { zone = "Silithus",        texture = TEX .. "thorium-ore-silithus" },
            { zone = "Eastern Plaguelands", texture = TEX .. "thorium-ore-epl" },
        },
    },

    -- TBC ORES 300-375

    {
        name = "Fel Iron Ore",
        type = "mining",
        skillRange = "300-325",
        zones = {
            { zone = "Hellfire Peninsula", texture = TEX .. "fel-iron-ore-hellfire" },
            { zone = "Terokkar Forest",    texture = TEX .. "fel-iron-ore-terokkar" },
            { zone = "Zangarmarsh",        texture = TEX .. "fel-iron-ore-zangarmarsh" },
        },
    },
    {
        name = "Adamantite Ore",
        type = "mining",
        skillRange = "325-375",
        zones = {
            { zone = "Nagrand",            texture = TEX .. "adamantite-ore-nagrand" },
            { zone = "Netherstorm",        texture = TEX .. "adamantite-ore-netherstorm" },
            { zone = "Shadowmoon Valley",  texture = TEX .. "adamantite-ore-shadowmoon" },
        },
    },
    {
        name = "Khorium Ore",
        type = "mining",
        skillRange = "375-375",
        zones = {
            { zone = "Netherstorm",        texture = TEX .. "khorium-ore-netherstorm" },
            { zone = "Shadowmoon Valley",  texture = TEX .. "khorium-ore-shadowmoon" },
        },
    },

    -- WOTLK ORES 375-450 - NUEVO PARA NAERZONE

    {
        name = "Cobalt Ore",
        type = "mining",
        skillRange = "375-400",
        zones = {
            { zone = "Howling Fjord",  texture = TEX .. "cobalt-ore-howling-fjord" },
            { zone = "Borean Tundra",  texture = TEX .. "cobalt-ore-borean-tundra" },
            { zone = "Dragonblight",   texture = TEX .. "cobalt-ore-dragonblight" },
            { zone = "Grizzly Hills",  texture = TEX .. "cobalt-ore-grizzly" },
            { zone = "Zul'Drak",       texture = TEX .. "cobalt-ore-zuldrak" },
        },
    },
    {
        name = "Saronite Ore",
        type = "mining",
        skillRange = "400-450",
        zones = {
            { zone = "Sholazar Basin",  texture = TEX .. "saronite-ore-sholazar" },
            { zone = "The Storm Peaks",texture = TEX .. "saronite-ore-storm-peaks" },
            { zone = "Icecrown",       texture = TEX .. "saronite-ore-icecrown" },
            { zone = "Wintergrasp",    texture = TEX .. "saronite-ore-wintergrasp" },
            { zone = "Zul'Drak",       texture = TEX .. "saronite-ore-zuldrak" },
            { zone = "Crystalsong Forest", texture = TEX .. "saronite-ore-crystalsong" },
        },
    },
    {
        name = "Titanium Ore",
        type = "mining",
        skillRange = "450-450",
        zones = {
            { zone = "The Storm Peaks",texture = TEX .. "titanium-ore-storm-peaks" },
            { zone = "Icecrown",       texture = TEX .. "titanium-ore-icecrown" },
            { zone = "Sholazar Basin", texture = TEX .. "titanium-ore-sholazar" },
            { zone = "Wintergrasp",    texture = TEX .. "titanium-ore-wintergrasp" },
        },
    },

    -- TBC GAS CLOUDS

    {
        name = "Windy Cloud",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Nagrand", texture = TEX .. "windy-cloud-nagrand" },
        },
    },
    {
        name = "Swamp Gas",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Zangarmarsh", texture = TEX .. "swamp-gas-zangarmarsh" },
        },
    },
    {
        name = "Felmist",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Shadowmoon Valley", texture = TEX .. "felmist-shadowmoon" },
        },
    },
    {
        name = "Arcane Vortex",
        type = "gases",
        skillRange = "305+",
        zones = {
            { zone = "Netherstorm", texture = TEX .. "arcane-vortex-netherstorm" },
        },
    },

    -- WOTLK GAS CLOUDS - NUEVO

    {
        name = "Concentrated Saronite Gas",
        type = "gases",
        skillRange = "400+",
        zones = {
            { zone = "Icecrown",
