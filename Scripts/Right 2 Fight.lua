-- Wait for game
repeat task.wait() until game:IsLoaded();

--UI Library
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua'))()
local Window = Library:Window({
    Text = "Right 2 Fight"
})
local Flags = Library.Flags

local StuffTab = Window:Tab({
    Text = "Stuff"  
})
local KillAuraSection = StuffTab:Section({
    Text = "Kill Aura"
})
local DungeonsSection = StuffTab:Section({
    Text = "Dungeons (Required lvl 10+)"
})

local Workspace = game:GetService("Workspace")
-- Aura Related
getgenv().KillAura = false; 
local Move;
-- Dungeon Related
local Diff = ''
local DungeonTable = {}
local Dungeons = game:GetService("Workspace").Map.Dungeons
local SelectedDungeon

-- Getting All Possible Arenas
for i,v in next, game:GetService("Workspace").Map.Dungeons:GetChildren() do
    table.insert(DungeonTable, v.Name)
end

local MoveDropDown = KillAuraSection:Dropdown({
    Text = "Difficulty",
    List = {'Easy', 'Normal', 'Hard', 'Legend'},
    Flag = "DifficultyChoosen",
    Callback = function(Value)
        Move = Value
    end
})

-- Credits to JOSHNXTDOOR for the open source Kill Aura https://v3rmillion.net/showthread.php?tid=1150826
function FuncKillAura()
    for i,v in next, game:GetService("Workspace").Bots.AI:GetChildren() do
        local A_1 = {
            [1] = "damage",
            [2] = v.UpperTorso,
            [3] = Vector3.new(v.HumanoidRootPart.Position),
            [4] = game:GetService("ReplicatedFirst").Moves.BTStrike4,   
            [5] = Move,
            [6] = 0.67969219472527
        }
        game:GetService("ReplicatedStorage").Events.ME:FireServer(A_1)
        task.wait()
    end
end

local label = KillAuraSection:Label({
    Text = "yeah no idea how to change this to a keybind.",
    Color = Color3.fromRGB(217, 97, 99),
    Tooltip = "if you know just make a pull request."
})

KillAuraSection:Toggle({
    Text = "Enable Kill Aura",
    Flags = "KillAuraFlag",
    Callback = function(v)
    KillAura = v;
        if ( KillAura ) then
            task.spawn(function()
                while KillAura do
                    FuncKillAura()
                end
            end)
        end
    end
})

-- Difficulties
local DifficultyDropDown = DungeonsSection:Dropdown({
    Text = "Difficulty",
    List = {'Easy', 'Normal', 'Hard', 'Legend'},
    Flag = "DifficultyChoosen",
    Callback = function(Value)
        Diff = Value;
    end
})

local ArenasDropDown = DungeonsSection:Dropdown({
    Text = "Dungeons",
    List = {DungeonTable},
    Flag = "DungeonChoosen",
    Callback = function(Value)
        SelectedDungeon = Value;
    end
})

DungeonsSection:Button({
    Text = "Start Dungeon",
    Tooltip = "This will start the dungeon.",
    function()
        local ohTable1 = {
            [1] = "dungeontime",
            [2] = Workspace.Map.Dungeons[SelectedDungeon].Area,
            [3] = Diff
        }
        game:GetService("ReplicatedStorage").Events.ME:FireServer(ohTable1)
        for i, val in pairs(ohTable1) do
            print(val)
        end
    end
})  
