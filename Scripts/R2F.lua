-- Wait for game
repeat task.wait() until game:IsLoaded();
--[[
    UI Library Made by ZCute(https://v3rmillion.net/member.php?action=profile&uid=1431869)
        he makes cool libs!1!
]]-- 
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rain-Design/Unnamed/main/Library.lua'))()
Library.Theme = "Dark"
local Window = Library:Window({
    Text = "Right 2 Fight Script"
})
local Flags = Library.Flags

local StuffTab = Window:Tab({
    Text = "Everything"  
})

local MiscTab = Window:Tab({
    Text = "Miscellaneous"  
})  

local KillAuraSection = StuffTab:Section({
    Text = "Kill Aura"
})

local DungeonsSection = StuffTab:Section({
    Text = "Dungeons"
})

local TPtoMobSection = StuffTab:Section({
    Text = "TP to Mob"
})

local MiniQuestSection = StuffTab:Section({
    Text = "Mini Quest"
})

local GUISection = MiscTab:Section({
    Text = "GUI"
})

task.spawn(function()
    local Blowjob = game:GetService("Players").LocalPlayer:FindFirstChild("Character"):FindFirstChild("Head")
end)
-- getgenvs
getgenv().KillAura = false;
-- Aura Related
local Move;
-- Dungeon Related
local Difficulty = '';
local DungeonTable = {};
local SelectedDungeon;
-- Auto TP Related
local MobTable = {};
local selectedMob;
-- Mini Quests Related
local MiniQuestNames = {};
local selectedMiniQuest;

pcall(function()
    -- Getting Tables and stuff
    for i,v in next, game:GetService("Workspace").Map.Dungeons:GetChildren() do
        if not table.find(DungeonTable, v.Name) then
            table.insert(DungeonTable, v.Name)
        end;
    end

    for i,v in next, game:GetService("Workspace").Bots.AI:GetDescendants() do
        if v:FindFirstChild("TouchInterest") then
            if not table.find(MobTable,v.Parent.Name) then
                table.insert(MobTable, v.Parent.Name)
            end;
        end;
    end

    for i,v in next, game:GetService("ReplicatedStorage").MiniQuests:GetDescendants() do
        if not table.find(MiniQuestNames,v.Name) then
            table.insert(MiniQuestNames, v.Name)
            task.wait()
        end;
    end
end)

function FuncTPtoMob()
    for i,v in next, game:GetService("Workspace").Bots.AI:GetDescendants() do
        if v.Name == selectedMob and v.Parent then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
            firetouchinterest(Blowjob, v.Parent, 0)
            task.wait()
        end;
    end;
end

function FuncKillAura()
    pcall(function()
        for i,v in next, game:GetService("Workspace").Bots.AI:GetChildren() do
            local A = {
                [1] = "damage",
                [2] = v.UpperTorso,
                [3] = Vector3.new(v.HumanoidRootPart.Position),
                [4] = game:GetService("ReplicatedFirst").Moves.BTStrike4,   
                [5] = Move,
                [6] = 1.4766920853780947
            }
            game:GetService("ReplicatedStorage").Events.ME:FireServer(A)
            task.wait();
        end
    end)
end

-- Difficulties
local MoveDropdown = KillAuraSection:Dropdown({
    Text = "Move",
    List = {'Fisticuffs', 'Frenzy', 'Beast'},
    Callback = function(v)
        Move = v;
    end
})

KillAuraSection:Toggle({
    Text = "Kill Aura",
    Callback = function(v)
    KillAura = v;
        if KillAura then
            task.spawn(function()
                while KillAura do
                    FuncKillAura()
                    task.wait()
                end
            end)
        end;
    end
})

-- Difficulties
local DifficultyDropDown = DungeonsSection:Dropdown({
    Text = "Difficulty",
    List = {'Easy', 'Normal', 'Hard', 'Legend'},
    Callback = function(v)
        Difficulty = v;
    end
})

local ArenasDropDown = DungeonsSection:Dropdown({
    Text = "Dungeons",
    List = DungeonTable,
    Callback = function(v)
        SelectedDungeon = v;
    end
})

DungeonsSection:Button({
    Text = "Start Dungeon",
    Tooltip = "This will start the dungeon.",
    Callback = function()
        local ohTable1 = {
            [1] = "dungeontime",
            [2] = game:GetService("Workspace").Map.Dungeons[SelectedDungeon].Area,
            [3] = Difficulty
        }

        game:GetService("ReplicatedStorage").Events.ME:FireServer(ohTable1);
    --[[
        for i, v in pairs(ohTable1) do
            print(v)
        end
    ]]--
    end
})

-- Difficulties
local TptoMobDropwdown = TPtoMobSection:Dropdown({
    Text = "Mob",
    List = MobTable,
    Callback = function(v)
        selectedMob = v;
    end
})

TPtoMobSection:Button({
    Text = "TP to Selected Mob",
    Callback = function()
        FuncTPtoMob();
    end
})

-- Difficulties
local MiniQuestDropdown = MiniQuestSection:Dropdown({
    Text = "Select MiniQuest",
    List = MiniQuestNames,
    Callback = function(v)
        selectedMiniQuest = v;
    end
})

MiniQuestSection:Button({
    Text = "Click to Start Mission",
    Callback = function()
        game:GetService("ReplicatedStorage").Events.StartMiniQuest:FireServer(selectedMiniQuest, 'Created by Anon')
    end
})

GUISection:Toggle({
    Text = "Keep GUI?",
    Callback = function(v)
        if v and queue_on_teleport then
            queue_on_teleport([[
              repeat task.wait(.1) until game:GetService('Players').LocalPlayer
              loadstring(game:HttpGet("https://raw.githubusercontent.com/TearTyr/My-Scripts/main/Scripts/R2F.lua", true))()
            ]])
        end
    end
})

game:GetService("Players").LocalPlayer.PlayerGui.Notif:Fire("Script Created by AnonMytical!")

StuffTab:Select()
