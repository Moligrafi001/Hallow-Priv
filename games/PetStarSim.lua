local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Pet Star Simulator!",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

-- Values
getgenv().AutoColStars = false
getgenv().AutoHatch = false

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local isAutoCollecting = false
local currentMap = "SPAWN" 
local selectedMap = "SPAWN"  

local function AutoCollectStars(mapName)
    if isAutoCollecting then
        print("Already collecting on map " .. currentMap .. ", stopping current collection.")
        return
    end

    isAutoCollecting = true
    currentMap = mapName  

    while getgenv().AutoColStars == true do
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if not character or not character:FindFirstChild("HumanoidRootPart") then
            warn("Character or HumanoidRootPart not found!")
            wait(1) 
            continue
        end

        local humanoidRootPart = character.HumanoidRootPart
        local localStars = Workspace:FindFirstChild("LocalStars")
        local spawnFolder = localStars and localStars:FindFirstChild(mapName)

        if not localStars or not spawnFolder then
            warn("Map " .. mapName .. " or SPAWN folder not found in LocalStars!")
            wait(1) 
            continue
        end

        local stars = spawnFolder:GetChildren()
        if #stars == 0 then
            warn("No stars found in SPAWN folder!")
            wait(1)
            continue
        end

        local randomStar = stars[math.random(1, #stars)]

        local primaryPart = randomStar:FindFirstChild("Primary")
        if not primaryPart or not primaryPart:IsA("BasePart") then
            warn("No valid 'Primary' part found in random star!")
            wait(0.5)
            continue
        end

        humanoidRootPart.CFrame = primaryPart.CFrame
        print("Teleported to star in map " .. mapName .. ": " .. randomStar.Name)

        local collectStarRemote = ReplicatedStorage:FindFirstChild("Core") and ReplicatedStorage.Core:FindFirstChild("Remote") and ReplicatedStorage.Core.Remote:FindFirstChild("collectStar")
        if collectStarRemote then
            collectStarRemote:FireServer(randomStar)  
            print("Collected star: " .. randomStar.Name)
        else
            warn("RemoteEvent 'collectStar' not found in ReplicatedStorage.Core.Remote!")
        end

        wait(0.1) 
    end

    isAutoCollecting = false
end

local function AutoHatchEggs()
    local hatchFunction = ReplicatedStorage:WaitForChild("PetSystem")
        :WaitForChild("Remotes")
        :WaitForChild("Hatch")

    while getgenv().AutoHatch == true do
        if hatchFunction and hatchFunction:IsA("RemoteFunction") then
            local success, response = pcall(function()
                return hatchFunction:InvokeServer(3)  
            end)

            if success then
                print("Hatched eggs successfully! Response:", response)
            else
                warn("Failed to hatch eggs! Error:", response)
            end
        else
            warn("Hatch RemoteFunction not found!")
            break
        end

        wait(3) 
    end
end


-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto collect stars")

local Dropdown = Menu:CreateDropdown({
    Name = "Select Map (If not unlocked it will NOT work.)",
    Options = {"SPAWN", "Autumn Forest", "Flower Garden", "Snow Forest", "Tropical Palms", "Mine Shaft", "Diamond Mine", "Magical Forest", "Sakura Forest"},
    CurrentOption = {"SPAWN"},
    MultipleOptions = false,
    Callback = function(Options)
        selectedMap = Options[1] 
        print("Selected map: " .. selectedMap)
    end,
})

local Toggle = Menu:CreateToggle({
    Name = "Start Auto Collect Stars",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoColStars = Value
        if Value then
            task.spawn(function()
                AutoCollectStars(selectedMap)
            end)
        else
            print("Auto Collect Stars stopped.")
        end
    end,
})

local Section = Menu:CreateSection("Auto open eggs")

local Toggle = Menu:CreateToggle({
    Name = "Start Auto Hatch Eggs",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoHatch = Value
        if Value then
            task.spawn(function()
                AutoHatchEggs()
            end)
        else
            print("Auto Hatch Eggs stopped.")
        end
    end,
})

local Section = Menu:CreateSection("Auto make golden pets")



-- Credits Section
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Creator")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Co - Creator")
local Label = Credits:CreateLabel("Discord: _prismx", "at-sign")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
local Button = Credits:CreateButton({
   Name = "Copy Server Link",
   Callback = function()
   	setclipboard("discord.gg/AESCuek87s")
   	toclipboard("discord.gg/AESCuek87s")
    end,
})
local Section = Credits:CreateSection("Note")
local Label = Credits:CreateLabel("If you find any bug join the discord and open a ticket")
