--//Settings

--[[
--//Regions:
"Outerwall"
"Yaramo"
"Vertigo"
"Midnight"
"Junction"
"Shallows"

--//Difficulty:
0 - Very easy
400 - Very hard (Recommended)

--//Info
Can only go if unlocked that region
Script requires melee weapon equipped
Execute in lobby and wait 10 seconds
]]

local Settings = {
    Region = "Midnight",
    LeaveAtRegion = nil, -- Replace with nil if wanna complete all regions until Junction
    Difficulty = 400,
    Special = true,
    NextRegion = false,
    AutoSell = true,
    RarityFilter = "Legendary" -- Examples: "Legendary" Ignores Legendary and above, "Alpha" Ignores Alpha and above. Filters: Legendary, Alpha, Omega, Core
}

--//Services
local HttpService = game:GetService("HttpService");

function saveSettings()
    local savedTable = HttpService:JSONEncode(Settings);

    writefile("NK_Settings.json", savedTable);
    Settings = HttpService:JSONDecode(readfile("NK_Settings.json"));
end

saveSettings();

loadstring(game:HttpGet("https://raw.githubusercontent.com/TearTyr/My-Scripts/main/Scripts/not%20mine/other.lua"))();
