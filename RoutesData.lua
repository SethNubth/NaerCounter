
-- NaerCounter  –  RoutesData.lua
-- Route data: Classic + TBC + WotLK Northrend 375-450
-- WotLK 3.3.5a 30300 esMX - Naerzone Edition

local _, NS = ...

local TEX = "Interface\\AddOns\\NaerCounter\\textures\\"

NS.RoutesData = {

    -- HORDE starting zones  (Skill 1-70)

    ["Durotar"] = {
        faction = "horde", skillRange = "1-70",
        herbs  = { texture = TEX .. "durotar-herbo" },
        mining = { texture = TEX .. "durotar-minage" },
    },
    ["Mulgore"] = {
        faction = "horde", skillRange = "1-70",
        herbs  = { texture = TEX .. "mulgore-herbo" },
        mining = { texture = TEX .. "mulgore-minage" },
    },
    ["Tirisfal Glades"] = {
        faction = "horde", skillRange = "1-70",
        herbs  = { texture = TEX .. "tirisfal-herbo" },
        mining = { texture = TEX .. "tirisfal-minage" },
    },

    -- ALLIANCE starting zones  (Skill 1-70)

    ["Dun Morogh"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "dun-morogh-herbo" },
        mining = { texture = TEX .. "dun-morogh-minage" },
    },
    ["Elwynn Forest"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "elwynn-herbo" },
        mining = { texture = TEX .. "elwynn-minage" },
    },
    ["Teldrassil"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "teldrassil-herbo" },
    },
    ["Darkshore"] = {
        faction = "alliance", skillRange = "1-70",
        herbs  = { texture = TEX .. "darkshore-herbo" },
        mining = { texture = TEX .. "darkshore-minage" },
    },

    -- Skill 70-115

    ["The Barrens"] = {
        faction = "horde", skillRange = "70-125",
        herbs  = { texture = TEX .. "barrens-herbo" },
        mining = { texture = TEX .. "barrens-minage" },
    },
    ["Silverpine Forest"] = {
        faction = "horde", skillRange = "70-115",
        herbs  = { texture = TEX .. "silverpine-herbo" },
    },
    ["Loch Modan"] = {
        faction = "alliance", skillRange = "70-115",
        herbs  = { texture = TEX .. "loch-modan-herbo" },
    },

    -- Skill 115-175

    ["Hillsbrad Foothills"] = {
        faction = "both", skillRange = "115-170",
        herbs  = { texture = TEX .. "hillsbrad-herbo" },
        mining = { texture = TEX .. "hillsbrad-minage" },
    },
    ["Wetlands"] = {
        faction = "alliance", skillRange = "115-170",
        herbs  = { texture = TEX .. "wetlands-herbo" },
    },
    ["Stonetalon Mountains"] = {
        faction = "both", skillRange = "115-170",
        herbs  = { texture = TEX .. "stonetalon-herbo" },
    },
    ["Redridge Mountains"] = {
        faction = "alliance", skillRange = "65-125",
        mining = { texture = TEX .. "redridge-minage" },
    },
    ["Ashenvale"] = {
        faction = "both", skillRange = "65-125",
        mining = { texture = TEX .. "ashenvale-minage" },
    },

    -- Skill 125-205

    ["Stranglethorn Vale"] = {
        faction = "both", skillRange = "170-205",
        herbs  = { texture = TEX .. "stv-herbo" },
    },
    ["Arathi Highlands"] = {
        faction = "both", skillRange = "125-205",
        herbs  = { texture = TEX .. "arathi-herbo" },
        mining = { texture = TEX .. "arathi-minage" },
    },
    ["Desolace"] = {
        faction = "both", skillRange = "125-175",
        mining = { texture = TEX .. "desolace-minage" },
    },
    ["Thousand Needles"] = {
        faction = "both", skillRange = "125-175",
        mining = { texture = TEX .. "thousand-needles-minage" },
    },

    -- Skill 205-270

    ["Tanaris"] = {
        faction = "both", skillRange = "205-245",
        herbs  = { texture = TEX .. "tanaris-herbo" },
        mining = { texture = TEX .. "tanaris-minage" },
    },
    ["Searing Gorge"] = {
        faction = "both", skillRange = "205-230",
        herbs  = { texture = TEX .. "searing-gorge-herbo" },
    },
    ["The Hinterlands"] = {
        faction = "both", skillRange = "230-270",
        herbs  = { texture = TEX .. "hinterlands-herbo" },
        mining = { texture = TEX .. "hinterlands-minage" },
    },

    -- Skill 245-300 + FIX ZONAS FALTANTES

    ["Feralas"] = {
        faction = "both", skillRange = "200-300",
        herbs  = { texture = TEX .. "feralas-herbo" },
        mining = { texture = TEX .. "feralas-minage" },
    },
    ["Badlands"] = {
        faction = "both", skillRange = "175-250",
        mining = { texture = TEX .. "badlands-minage" },
    },
    ["Dustwallow Marsh"] = {
        faction = "both", skillRange = "200-300",
        herbs  = { texture = TEX .. "dustwallow-herbo" },
    },
    ["Swamp of Sorrows"] = {
        faction = "both", skillRange = "200-250",
        herbs  = { texture = TEX .. "swamp-sorrows-herbo" },
    },
    ["Duskwood"] = {
        faction = "alliance", skillRange = "115-170",
        herbs  = { texture = TEX .. "duskwood-herbo" },
    },
    ["Silithus"] = {
        faction = "both", skillRange = "275-300",
        herbs  = { texture = TEX .. "silithus-herbo" },
        mining = { texture = TEX .. "silithus-minage" },
    },
    ["Azshara"] = {
        faction = "both", skillRange = "200-300",
        herbs  = { texture = TEX .. "azshara-herbo" },
        mining = { texture = TEX .. "azshara-minage" },
    },
    ["Western Plaguelands"] = {
        faction = "both", skillRange = "200-300",
        herbs  = { texture = TEX .. "western-plaguelands-herbo" },
    },
    ["Felwood"] = {
        faction = "both", skillRange = "270-300",
        herbs  = { texture = TEX .. "felwood-herbo" },
        mining = { texture = TEX .. "felwood-minage" },
    },
    ["Un'Goro Crater"] = {
        faction = "both", skillRange = "245-300",
        herbs  = { texture = TEX .. "ungoro-herbo" },
        mining = { texture = TEX .. "ungoro-minage" },
    },
    ["Blasted Lands"] = {
        faction = "both", skillRange = "245-275",
        mining = { texture = TEX .. "blasted-lands-minage" },
    },
    ["Eastern Plaguelands"] = {
        faction = "both", skillRange = "275-300",
        mining = { texture = TEX .. "eastern-plaguelands-minage" },
    },
    ["Winterspring"] = {
        faction = "both", skillRange = "275-300",
        mining = { texture = TEX .. "winterspring-minage" },
    },
    ["Burning Steppes"] = {
        faction = "both", skillRange = "275-300",
        mining = { texture = TEX .. "burning-steppes-minage" },
    },

    -- TBC Outland  (Skill 300-375)

    ["Hellfire Peninsula"] = {
        faction = "both", skillRange = "300-325",
        herbs  = { texture = TEX .. "hellfire-herbo" },
        mining = { texture = TEX .. "hellfire-minage" },
    },
    ["Zangarmarsh"] = {
        faction = "both", skillRange = "325-350",
        mining = { texture = TEX .. "zangarmarsh-minage" },
        gases  = { texture = TEX .. "zangarmarsh-gases" },
    },
    ["Terokkar Forest"] = {
        faction = "both", skillRange = "325-350",
        herbs  = { texture = TEX .. "terokkar-herbo" },
        mining = { texture = TEX .. "terokkar-minage" },
    },
    ["Nagrand"] = {
        faction = "both", skillRange = "315-375",
        herbs  = { texture = TEX .. "nagrand-herbo" },
        mining = { texture = TEX .. "nagrand-minage" },
        gases  = { texture = TEX .. "nagrand-gases" },
    },
    ["Blade's Edge Mountains"] = {
        faction = "both", skillRange = "315-325",
        herbs  = { texture = TEX .. "blades-edge-herbo" },
    },
    ["Netherstorm"] = {
        faction = "both", skillRange = "350-375",
        herbs  = { texture = TEX .. "netherstorm-herbo" },
        mining = { texture = TEX .. "netherstorm-minage" },
        gases  = { texture = TEX .. "netherstorm-gases" },
    },
    ["Shadowmoon Valley"] = {
        faction = "both", skillRange = "350-375",
        mining = { texture = TEX .. "shadowmoon-minage" },
        gases  = { texture = TEX .. "shadowmoon-gases" },
    },

    -- WotLK Northrend  (Skill 375-450) - NUEVO NAERZONE

    ["Howling Fjord"] = {
        faction = "both", skillRange = "375-400",
        herbs  = { texture = TEX .. "howling-fjord-herbo" },
        mining = { texture = TEX .. "howling-fjord-minage" },
    },
    ["Borean Tundra"] = {
        faction = "both", skillRange = "375-400",
        herbs  = { texture = TEX .. "borean-tundra-herbo" },
        mining = { texture = TEX .. "borean-tundra-minage" },
    },
    ["Dragonblight"] = {
        faction = "both", skillRange = "400-425",
        herbs  = { texture = TEX .. "dragonblight-herbo" },
        mining = { texture = TEX .. "dragonblight-minage" },
    },
    ["Grizzly Hills"] = {
        faction = "both", skillRange = "400-425",
        herbs  = { texture = TEX .. "grizzly-herbo" },
        mining = { texture = TEX .. "grizzly-minage" },
    },
    ["Zul'Drak"] = {
        faction = "both", skillRange = "400-450",
        herbs  = { texture = TEX .. "zuldrak-herbo" },
        mining = { texture = TEX .. "zuldrak-minage" },
    },
    ["Sholazar Basin"] = {
        faction = "both", skillRange = "425-450",
        herbs  = { texture = TEX .. "sholazar-herbo" },
        mining = { texture = TEX .. "sholazar-minage" },
    },
    ["The Storm Peaks"] = {
        faction = "both", skillRange = "425-450",
        herbs  = { texture = TEX .. "storm-peaks-herbo" },
        mining = { texture = TEX .. "storm-peaks-minage" },
    },
    ["Icecrown"] = {
        faction = "both", skillRange = "425-450",
        herbs  = { texture = TEX .. "icecrown-herbo" },
        mining = { texture = TEX .. "icecrown-minage" },
    },
    ["Wintergrasp"] = {
        faction = "both", skillRange = "425-450",
        herbs  = { texture = TEX .. "wintergrasp-herbo" },
        mining = { texture = TEX .. "wintergrasp-minage" },
    },
}

-- Zone name aliases

NS.RouteZoneAliases = {
    -- FR Classic
    ["Clairières de Tirisfal"] = "Tirisfal Glades",
    ["Forêt d'Elwynn"] = "Elwynn Forest",
    ["Sombrivage"] = "Darkshore",
    ["Les Tarides"] = "The Barrens",
    ["Forêt des Pins Argentés"] = "Silverpine Forest",
    ["Contreforts de Hillsbrad"] = "Hillsbrad Foothills",
    ["Les Paluns"] = "Wetlands",
    ["Serres-Rocheuses"] = "Stonetalon Mountains",
    ["Les Carmines"] = "Redridge Mountains",
    ["Vallée de Strangleronce"] = "Stranglethorn Vale",
    ["Hautes-terres d'Arathi"] = "Arathi Highlands",
    ["Désolace"] = "Desolace",
    ["Mille Pointes"] = "Thousand Needles",
    ["Steppes ardentes"] = "Searing Gorge",
    ["Les Hinterlands"] = "The Hinterlands",
    ["Gangrebois"] = "Felwood",
    ["Cratère d'Un'Goro"] = "Un'Goro Crater",
    ["Terres Foudroyées"] = "Blasted Lands",
    ["Maleterres de l'est"] = "Eastern Plaguelands",
    ["Berceau-de-l'Hiver"] = "Winterspring",
    ["Steppes Ardentes"] = "Burning Steppes",
    -- FR TBC
    ["Péninsule des Flammes infernales"] = "Hellfire Peninsula",
    ["Marécage de Zangar"] = "Zangarmarsh",
    ["Forêt de Terokkar"] = "Terokkar Forest",
    ["Les Tranchantes"] = "Blade's Edge Mountains",
    ["Raz-de-Néant"] = "Netherstorm",
    ["Vallée d'Ombrelune"] = "Shadowmoon Valley",
    -- FR WotLK
    ["Fjord Hurlant"] = "Howling Fjord",
    ["Toundra Boréenne"] = "Borean Tundra",
    ["Désolation des dragons"] = "Dragonblight",
    ["Les Grisonnes"] = "Grizzly Hills",
    ["Cuenca de Sholazar"] = "Sholazar Basin",
    ["Les pics foudroyés"] = "The Storm Peaks",
    ["Couronne de glace"] = "Icecrown",
    ["Joug-d'hiver"] = "Wintergrasp",
    -- DE Classic/TBC (same as before)
    ["Das Brachland"] = "The Barrens",
    ["Silberwald"] = "Silverpine Forest",
    ["Sumpfland"] = "Wetlands",
    ["Steinkrallengebirge"] = "Stonetalon Mountains",
    ["Rotkammgebirge"] = "Redridge Mountains",
    ["Eschental"] = "Ashenvale",
    ["Schlingendorntal"] = "Stranglethorn Vale",
    ["Arathihochland"] = "Arathi Highlands",
    ["Tausend Nadeln"] = "Thousand Needles",
    ["Sengende Schlucht"] = "Searing Gorge",
    ["Das Hinterland"] = "The Hinterlands",
    ["Teufelswald"] = "Felwood",
    ["Krater von Un'Goro"] = "Un'Goro Crater",
    ["Verwüstete Lande"] = "Blasted Lands",
    ["Östliche Pestländer"] = "Eastern Plaguelands",
    ["Winterquell"] = "Winterspring",
    ["Brennende Steppe"] = "Burning Steppes",
    ["Höllenfeuerhalbinsel"] = "Hellfire Peninsula",
    ["Zangarmarschen"] = "Zangarmarsh",
    ["Wälder von Terokkar"] = "Terokkar Forest",
    ["Schergrat"] = "Blade's Edge Mountains",
    ["Nethersturm"] = "Netherstorm",
    ["Schattenmondtal"] = "Shadowmoon Valley",
    -- DE WotLK
    ["Heulender Fjord"] = "Howling Fjord",
    ["Boreanische Tundra"] = "Borean Tundra",
    ["Drachenöde"] = "Dragonblight",
    ["Grizzlyhügel"] = "Grizzly Hills",
    ["Sholazarbecken"] = "Sholazar Basin",
    ["Die Sturmgipfel"] = "The Storm Peaks",
    ["Eiskrone"] = "Icecrown",
    ["Tausendwintersee"] = "Wintergrasp",

    -- ES / esMX - CLAVE PARA NAERZONE
    ["Bosque de Elwynn"] = "Elwynn Forest",
    ["Claros de Tirisfal"] = "Tirisfal Glades",
    ["Costa Oscura"] = "Darkshore",
    ["Los Baldíos"] = "The Barrens",
    ["Bosque de Argénteos"] = "Silverpine Forest",
    ["Laderas de Trabalomas"] = "Hillsbrad Foothills",
    ["Los Humedales"] = "Wetlands",
    ["Sierra Espolón"] = "Stonetalon Mountains",
    ["Montañas Crestagrana"] = "Redridge Mountains",
    ["Valle de Vega de Tuercespina"] = "Stranglethorn Vale",
    ["Tierras Altas de Arathi"] = "Arathi Highlands",
    ["Desolace"] = "Desolace",
    ["Las Mil Agujas"] = "Thousand Needles",
    ["Garganta del Fuego"] = "Searing Gorge",
    ["Tierras del Interior"] = "The Hinterlands",
    ["Frondavil"] = "Felwood",
    ["Cráter de Un'Goro"] = "Un'Goro Crater",
    ["Tierras Devastadas"] = "Blasted Lands",
    ["Tierras de la Peste del Este"] = "Eastern Plaguelands",
    ["Cuna del Invierno"] = "Winterspring",
    ["La Garganta de Fuego"] = "Burning Steppes",
    ["Península del Fuego Infernal"] = "Hellfire Peninsula",
    ["Marisma de Zangar"] = "Zangarmarsh",
    ["Bosque de Terokkar"] = "Terokkar Forest",
    ["Montañas Filospada"] = "Blade's Edge Mountains",
    ["Tormenta Abisal"] = "Netherstorm",
    ["Valle Sombraluna"] = "Shadowmoon Valley",
    -- ES WotLK Naerzone
    ["Fiordo Aquilonal"] = "Howling Fjord",
    ["Tundra Boreal"] = "Borean Tundra",
    ["Cementerio de Dragones"] = "Dragonblight",
    ["Colinas Pardas"] = "Grizzly Hills",
    ["Zul'Drak"] = "Zul'Drak",
    ["Cuenca de Sholazar"] = "Sholazar Basin",
    ["Las Cumbres Tormentosas"] = "The Storm Peaks",
    ["Corona de Hielo"] = "Icecrown",
    ["Conquista del Invierno"] = "Wintergrasp",

    -- Extra zones
    ["Feralas"] = "Feralas",
    ["Féralas"] = "Feralas",
    ["Badlands"] = "Badlands",
    ["Tierras Inhóspitas"] = "Badlands",
    ["Terres ingrates"] = "Badlands",
    ["Ödland"] = "Badlands",
    ["Silithus"] = "Silithus",
}

-- Reverse locale table

NS.ZoneLocales = {
    ["frFR"] = {
        ["Tirisfal Glades"] = "Clairières de Tirisfal",
        ["Elwynn Forest"] = "Forêt d'Elwynn",
        ["Darkshore"] = "Sombrivage",
        ["The Barrens"] = "Les Tarides",
        ["Silverpine Forest"] = "Forêt des Pins Argentés",
        ["Hillsbrad Foothills"] = "Contreforts de Hillsbrad",
        ["Wetlands"] = "Les Paluns",
        ["Stonetalon Mountains"] = "Serres-Rocheuses",
        ["Redridge Mountains"] = "Les Carmines",
        ["Stranglethorn Vale"] = "Vallée de Strangleronce",
        ["Arathi Highlands"] = "Hautes-terres d'Arathi",
        ["Desolace"] = "Désolace",
        ["Thousand Needles"] = "Mille Pointes",
        ["Searing Gorge"] = "Steppes ardentes",
        ["The Hinterlands"] = "Les Hinterlands",
        ["Felwood"] = "Gangrebois",
        ["Un'Goro Crater"] = "Cratère d'Un'Goro",
        ["Blasted Lands"] = "Terres Foudroyées",
        ["Eastern Plaguelands"] = "Maleterres de l'est",
        ["Winterspring"] = "Berceau-de-l'Hiver",
        ["Burning Steppes"] = "Steppes Ardentes",
        ["Hellfire Peninsula"] = "Péninsule des Flammes infernales",
        ["Zangarmarsh"] = "Marécage de Zangar",
        ["Terokkar Forest"] = "Forêt de Terokkar",
        ["Blade's Edge Mountains"] = "Les Tranchantes",
        ["Netherstorm"] = "Raz-de-Néant",
        ["Shadowmoon Valley"] = "Vallée d'Ombrelune",
        ["Howling Fjord"] = "Fjord Hurlant",
        ["Borean Tundra"] = "Toundra Boréenne",
        ["Dragonblight"] = "Désolation des dragons",
        ["Grizzly Hills"] = "Les Grisonnes",
        ["Sholazar Basin"] = "Cuenca de Sholazar",
        ["The Storm Peaks"] = "Les pics foudroyés",
        ["Icecrown"] = "Couronne de glace",
        ["Wintergrasp"] = "Joug-d'hiver",
    },
    ["deDE"] = {
        ["Tirisfal Glades"] = "Lichtung von Tirisfal",
        ["Elwynn Forest"] = "Wald von Elwynn",
        ["Darkshore"] = "Dunkelküste",
        ["The Barrens"] = "Das Brachland",
        ["Silverpine Forest"] = "Silberwald",
        ["Hillsbrad Foothills"] = "Vorgebirge des Hügellands",
        ["Wetlands"] = "Sumpfland",
        ["Stonetalon Mountains"] = "Steinkrallengebirge",
        ["Redridge Mountains"] = "Rotkammgebirge",
        ["Stranglethorn Vale"] = "Schlingendorntal",
        ["Arathi Highlands"] = "Arathihochland",
        ["Thousand Needles"] = "Tausend Nadeln",
        ["Searing Gorge"] = "Sengende Schlucht",
        ["The Hinterlands"] = "Das Hinterland",
        ["Felwood"] = "Teufelswald",
        ["Un'Goro Crater"] = "Krater von Un'Goro",
        ["Blasted Lands"] = "Verwüstete Lande",
        ["Eastern Plaguelands"] = "Östliche Pestländer",
        ["Winterspring"] = "Winterquell",
        ["Burning Steppes"] = "Brennende Steppe",
        ["Hellfire Peninsula"] = "Höllenfeuerhalbinsel",
        ["Zangarmarsh"] = "Zangarmarschen",
        ["Terokkar Forest"] = "Wälder von Terokkar",
        ["Blade's Edge Mountains"] = "Schergrat",
        ["Netherstorm"] = "Nethersturm",
        ["Shadowmoon Valley"] = "Schattenmondtal",
        ["Howling Fjord"] = "Heulender Fjord",
        ["Borean Tundra"] = "Boreanische Tundra",
        ["Dragonblight"] = "Drachenöde",
        ["Grizzly Hills"] = "Grizzlyhügel",
        ["Sholazar Basin"] = "Sholazarbecken",
        ["The Storm Peaks"] = "Die Sturmgipfel",
        ["Icecrown"] = "Eiskrone",
        ["Wintergrasp"] = "Tausendwintersee",
    },
    ["esES"] = {
        ["Elwynn Forest"] = "Bosque de Elwynn",
        ["Tirisfal Glades"] = "Claros de Tirisfal",
        ["Darkshore"] = "Costa Oscura",
        ["The Barrens"] = "Los Baldíos",
        ["Silverpine Forest"] = "Bosque de Argénteos",
        ["Hillsbrad Foothills"] = "Laderas de Trabalomas",
        ["Wetlands"] = "Los Humedales",
        ["Stonetalon Mountains"] = "Sierra Espolón",
        ["Redridge Mountains"] = "Montañas Crestagrana",
        ["Stranglethorn Vale"] = "Vega de Tuercespina",
        ["Arathi Highlands"] = "Tierras Altas de Arathi",
        ["Thousand Needles"] = "Las Mil Agujas",
        ["Searing Gorge"] = "Garganta del Fuego",
        ["The Hinterlands"] = "Tierras del Interior",
        ["Felwood"] = "Frondavil",
        ["Un'Goro Crater"] = "Cráter de Un'Goro",
        ["Blasted Lands"] = "Tierras Devastadas",
        ["Eastern Plaguelands"] = "Tierras de la Peste del Este",
        ["Winterspring"] = "Cuna del Invierno",
        ["Burning Steppes"] = "Montaña Roca Negra",
        ["Hellfire Peninsula"] = "Península del Fuego Infernal",
        ["Zangarmarsh"] = "Marisma de Zangar",
        ["Terokkar Forest"] = "Bosque de Terokkar",
        ["Blade's Edge Mountains"] = "Montañas Filospada",
        ["Netherstorm"] = "Tormenta Abisal",
        ["Shadowmoon Valley"] = "Valle Sombraluna",
        ["Howling Fjord"] = "Fiordo Aquilonal",
        ["Borean Tundra"] = "Tundra Boreal",
        ["Dragonblight"] = "Cementerio de Dragones",
        ["Grizzly Hills"] = "Colinas Pardas",
        ["Sholazar Basin"] = "Cuenca de Sholazar",
        ["The Storm Peaks"] = "Las Cumbres Tormentosas",
        ["Icecrown"] = "Corona de Hielo",
        ["Wintergrasp"] = "Conquista
