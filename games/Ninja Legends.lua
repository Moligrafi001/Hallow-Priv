-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Priv/refs/heads/main/games/NinjaLegends.lua?token=GHSAT0AAAAAAC4PUKQN7X62DKLTISICB5ZKZ4F2GJQ",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Ninja Legends⭐",
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi & PrismX",
    Theme = "Amethyst"
})

local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Plr = game:GetService("Players").LocalPlayer
local NinjaEvent = Plr:FindFirstChild("ninjaEvent")
local Player = game.Players.LocalPlayer

-- Globals
getgenv().NL_Config = NL_Config
getgenv().AutoSwing = false
getgenv().AutoSell = false
getgenv().AutoSellPets = false
getgenv().AutoHatch = false
getgenv().AutoEvolve = false
getgenv().SwingDelay = "0.5"
getgenv().FarmHoops = false
getgenv().AutoPurchaseSwords = false
getgenv().AutoPurchaseBelts = false
getgenv().AutoUpgradeSkills = false
getgenv().IslandToPurchaseFrom = "Ground"
getgenv().CrystalToHatch = "Blue Crystal"
getgenv().UnlockAllIslands = false 
getgenv().TeleportToRandomCoin = false 
getgenv().AutoJoinDuels = false
getgenv().PetToSell = false
getgenv().AutoTeleportToBoss = false
getgenv().AutoCollectSouls = false
getgenv().AutoMaster = false
getgenv().AutoPurchaseShurs = false

-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
_G.SetWalkSpeed = false
_G.SetJumpPower = false
_G.InfJump = false
_G.NoClip = false
local function SetWalkSpeed()
	while _G.SetWalkSpeed == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
		end
		wait(0.01)
	end
	if _G.SetWalkSpeed == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end
local function SetJumpPower()
	while _G.SetJumpPower == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower ~= JumpPowerText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = JumpPowerText
		end
		wait(0.01)
		end
	if _G.SetJumpPower == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
	end
end
local function InfJump()
	while _G.InfJump == true do
		game:GetService("UserInputService").JumpRequest:connect(function()
			if _G.InfJump == true then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
		wait(0.1)
	end
end
local function NoClip()
	while _G.NoClip == true do
		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if _G.NoClip then
					part.CanCollide = false
				else
					part.CanCollide = true
				end
			end
		end
		wait(0.1)
	end
end

local function AutoSwing()
    task.spawn(function()
        while getgenv().AutoSwing do
            pcall(function()
                local Weapon
                for _, Tool in pairs(Plr.Backpack:GetChildren()) do
                    if Tool:FindFirstChild("ninjitsuGain") then
                        Weapon = Tool
                    end
                end

                if Weapon then
                    Plr.Character:FindFirstChildOfClass("Humanoid"):EquipTool(Weapon)
                end
            end)

            -- Fire the swing event
            NinjaEvent:FireServer("swingKatana")
            task.wait(tonumber(getgenv().SwingDelay) or 0)
        end
    end)
end

local Menu = Window:CreateTab("Main", "square-function")
local Section = Menu:CreateSection("Mastery")

local elements = {
    "Inferno",
    "Lightning",
    "Frost",
    "Shadow Charge",
    "Masterful Wrath",
    "Electral Chaos",
    "Shadowfire",
    "Eternity Storm",
    "Blazing Entity"
}

local Button = Menu:CreateButton({
    Name = "Master ALL Elements",
    Info = "Resets ALL Ranks and Swords/Belts",
    Callback = function()
        for _, element in ipairs(elements) do
            local args = {
                [1] = element
            }
            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("elementMasteryEvent"):FireServer(unpack(args))
            print("Attempted to master " .. element .. " element")
            task.wait(0.1)
        end
        print("Attempted to master ALL elements")
    end
})

local AutofarmSection = Menu:CreateSection("Main Features")

local ToggleSwing = Menu:CreateToggle({
    Name = "Auto Swing",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoSwing = state
        if state then
            AutoSwing()
        end
    end
})
local ToggleAutoUpgradeSkills = Menu:CreateToggle({
    Name = "Auto Upgrade Skills",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoUpgradeSkills = state

        if state then
            while getgenv().AutoUpgradeSkills do
                pcall(function()
                    getgenv().IslandToPurchaseFrom = "Blazing Vortex Island"
                    NinjaEvent:FireServer("buyAllSkills", getgenv().IslandToPurchaseFrom)
                end)

                wait(0.5) 
            end
        else
            getgenv().AutoUpgradeSkills = false
        end
    end
})

local ranks = { 
    "Rookie", "Grasshopper", "Apprentice", "Samurai", "Assassin", "Shadow", "Ninja", 
    "Master Ninja", "Sensei", "Master Sensei", "Ninja Legend", "Master Of Shadows", 
    "Immortal Assassin", "Eternity Hunter", "Shadow Legend", "Dragon Warrior", 
    "Dragon Master", "Chaos Sensei", "Chaos Legend", "Master Of Elements", 
    "Elemental Legend", "Ancient Battle Master", "Ancient Battle Legend", 
    "Legendary Shadow Duelist", "Master Legend Assassin", "Mythic Shadowmaster", 
    "Legendary Shadowmaster", "Awakened Scythemaster", "Awakened Scythe Legend", 
    "Master Legend Zephyr", "Golden Sun Shuriken Master", "Golden Sun Shuriken Legend", 
    "Dark Sun Samurai Legend", "Dragon Evolution Form I", "Dragon Evolution Form II", 
    "Dragon Evolution Form III", "Dragon Evolution Form IV", "Dragon Evolution Form V", 
    "Cybernetic Electro Master", "Cybernetic Electro Legend", "Shadow Chaos Assassin", 
    "Shadow Chaos Legend", "Infinity Sensei", "Infinity Legend", 
    "Aether Genesis Master Ninja", "Master Legend Sensei Hunter", 
    "Skystorm Series Samurai Legend", "Master Elemental Hero", 
    "Eclipse Series Soul Master", "Starstrike Master Sensei", 
    "Evolved Series Master Ninja", "Dark Elements Guardian", 
    "Elite Series Master Legend", "Infinity Shadows Master", "Lightning Storm Sensei", 
    "Dark Elements Blademaster", "Rising Shadow Eternal Ninja", "Skyblade Ninja Master", 
    "Shadow Storm Sensei", "Comet Strike Lion", "Cybernetic Azure Sensei", 
    "Ultra Genesis Shadow" 
}

local ToggleAutoBuyRanks = Menu:CreateToggle({
    Name = "Auto Buy Ranks",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoBuyRanks = state

        if state then
            task.spawn(function()
                while getgenv().AutoBuyRanks do
   
                    local currentRank = Plr.leaderstats.Rank.Value


                    local nextRankIndex = table.find(ranks, currentRank) + 1
                    local nextRank = ranks[nextRankIndex]

                    if not nextRank then
                        print("All ranks purchased!")
                        break
                    end

                    local args = {
                        [1] = "buyRank",
                        [2] = nextRank
                    }

                    pcall(function()
                        game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    end)

                    task.wait(1) 
                end
            end)
        end
    end
})


if not getgenv().NL_Config then
    getgenv().NL_Config = {
        BuySwords = false,
        BuyBelts = false,
        BuyShurs = false,
    }
end
    
local Config = getgenv().NL_Config

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    error("LocalPlayer is nil! Make sure the game has loaded.")
end

-- Define Islands
local NL_Islands = {
    "Enchanted Island",
    "Astral Island",
    "Mystical Island",
    "Space Island",
    "Tundra Island",
    "Eternal Island",
    "Sandstorm",
    "Thunderstorm",
    "Ancient Inferno Island",
    "Midnight Shadow Island",
    "Mythical Souls Island",
    "Winter Wonder Island",
    "Golden Master Island",
    "Dragon Legend Island",
    "Cybernetic Legends Island",
    "Skystorm Ultraus Island",
    "Chaos Legends Island",
    "Soul Fusion Island",
    "Inner Peace Island",
    "Blazing Vortex Island"
}

local function GetLastIsland()
    return NL_Islands[#NL_Islands]
end
local LastIsland = GetLastIsland()

local function GameEvent(...)
    local NinjaEvent = LocalPlayer:FindFirstChild("ninjaEvent")

    if not NinjaEvent then
        warn("NinjaEvent not found!")
        return
    end

    NinjaEvent:FireServer(...)
end

local function BuySwords()
    if not Config.BuySwords then
        print("BuySwords is disabled")
        return
    end

    print("Buying all swords for:", LastIsland)
    GameEvent("buyAllSwords", LastIsland)
end

-- BuyBelts Function
local function BuyBelts()
    if not Config.BuyBelts then
        print("BuyBelts is disabled")
        return
    end

    GameEvent("buyAllBelts", LastIsland)
end

local function BuyShurs()
    if not Config.BuyShurs then
        print("BuyShurs is disabled")
        return
    end

    GameEvent("buyAllShurikens", LastIsland)
end

local TogglePurchaseSwords = Menu:CreateToggle({
    Name = "Auto Purchase Swords",
    CurrentValue = Config.BuySwords,  
    Callback = function(state)
        Config.BuySwords = state  
        getgenv().AutoPurchaseSwords = state
        if state then
            task.spawn(function()
                while getgenv().AutoPurchaseSwords do
                    BuySwords()
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- Toggle for Auto Purchase Belts
local TogglePurchaseBelts = Menu:CreateToggle({
    Name = "Auto Purchase Belts",
    CurrentValue = Config.BuyBelts, 
    Callback = function(state)
        Config.BuyBelts = state 
        getgenv().AutoPurchaseBelts = state
        if state then
            task.spawn(function()
                while getgenv().AutoPurchaseBelts do
                    BuyBelts()
                    task.wait(0.5)
                end
            end)
        end
    end
})

local TogglePurchaseShurikens = Menu:CreateToggle({
    Name = "Auto Purchase Shurikens",
    CurrentValue = Config.BuyShurs, 
    Callback = function(state)
        Config.BuyShurs = state 
        getgenv().AutoPurchaseShurs = state
        if state then
            task.spawn(function()
                while getgenv().AutoPurchaseShurs do
                    BuyShurs()
                    task.wait(0.45)
                end
            end)
        end
    end
})

local ToggleHoops = Menu:CreateToggle({
    Name = "Collect all Hoops (Auto)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().FarmHoops = state
        if state then
            task.spawn(function()
                while getgenv().FarmHoops do
                    pcall(function()
                        for _, hoop in pairs(game:GetService("Workspace").Hoops:GetChildren()) do
                            if getgenv().FarmHoops then
                                local args = {
                                    [1] = "useHoop",
                                    [2] = hoop
                                }

                                game:GetService("ReplicatedStorage").rEvents.hoopEvent:FireServer(unpack(args))

                                task.wait(tonumber(getgenv().HoopDelay) or 0.001) 
                            end
                        end
                    end)
                end
            end)
        end
    end
})

local collectSoulsToggle = Menu:CreateToggle({
    Name = "Auto Collect Souls",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoCollectSouls = state
        
        if state then
            print("Auto Collect Souls enabled")
            task.spawn(function()
                while getgenv().AutoCollectSouls do
                    local args = {
                        [1] = "collectSoul",
                        [2] = workspace:WaitForChild("soulPartsFolder"):WaitForChild("soulPart")
                    }
                    game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    task.wait(0.5) 
                end
            end)
        else
            print("Auto Collect Souls disabled")
        end
    end
})

local AutofarmSection = Menu:CreateSection("Auto Sell $")

local AutoSellConnectioninsta = nil 

local Toggle = Menu:CreateToggle({
    Name = "Instant Auto Sell",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoSell = state

        if AutoSellConnectioninsta then
            AutoSellConnectioninsta:Disconnect() 
            AutoSellConnectioninsta = nil
        end

        if state then
            AutoSellConnectioninsta = Plr.leaderstats.Ninjitsu:GetPropertyChangedSignal("Value"):Connect(function()
                local CurrentNinjitsu = Plr.leaderstats.Ninjitsu
                local sellPart = game:GetService("Workspace").sellAreaCircles.sellAreaCircle16.circleInner

                -- Only sell if Ninjitsu is greater than 0
                if CurrentNinjitsu.Value > 0 then
                    -- Trigger the sell action
                    firetouchinterest(sellPart, Plr.Character.Head, 1)
                    task.wait(0.5)
                    firetouchinterest(sellPart, Plr.Character.Head, 0)
                end
            end)
        end
    end
})


local AutofarmSection = Menu:CreateSection("Other")

local chestNames = {
    "enchantedChest",
    "magmaChest",
    "mythicalChest",
    "legendsChest",
    "eternalChest",
    "saharaChest",
    "thunderChest",
    "ancientChest",
    "midnightShadowChest",
    "wonderChest",
    "goldenZenChest",
    "ultraNinjitsuChest",
    "skystormMastersChest",
    "chaosLegendsChest",
    "soulFusionChest"
}

local ToggleUnlockChests = Menu:CreateToggle({
    Name = "Unlock All Chests (take a little bit of time)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().UnlockAllChests = state
        
        if state then
            task.spawn(function()
                while getgenv().UnlockAllChests do
                    for _, chestName in ipairs(chestNames) do
                        local chest = workspace:FindFirstChild(chestName)
                        if chest then
                            local circleInner = chest:FindFirstChild("circleInner")
                            if circleInner then
                                local touchInterest = circleInner:FindFirstChild("TouchInterest")
                                if touchInterest then
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, circleInner, 0)
                                    task.wait(0.1)
                                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, circleInner, 1)
                                else
                                    print("TouchInterest not found in " .. chestName)
                                end
                            else
                                print("circleInner not found in " .. chestName)
                            end
                        else
                            print(chestName .. " not found in workspace")
                        end
                        task.wait(2) -- Wait half a second between each chest interaction
                    end
                    task.wait(1) -- Wait 1 second before starting the next cycle
                end
            end)
        end
    end
})


local ToggleRandomCoinTeleport = Menu:CreateToggle({
    Name = "Auto Collect Coin/weird circle thing Crates",
    CurrentValue = false,
    Callback = function(state)
        getgenv().TeleportToRandomCoin = state
        if state then
            task.spawn(function()
                local coinSpawns = game:GetService("Workspace").spawnedCoins.Valley
                

                while getgenv().TeleportToRandomCoin do

                    local coinSpawnsList = coinSpawns:GetChildren()

                    if #coinSpawnsList > 0 then

                        local randomCoinSpawn = coinSpawnsList[math.random(1, #coinSpawnsList)]

                        if randomCoinSpawn:IsA("BasePart") then
                            local playerHead = Plr.Character:WaitForChild("Head")

                            Plr.Character:SetPrimaryPartCFrame(CFrame.new(randomCoinSpawn.Position))
                        end
                    end
                    wait(0.35) 
                end
            end)
        end
    end
})



local Player = Window:CreateTab("Player", "person-standing")
local Section = Player:CreateSection("Island things")

local ToggleUnlockIslands = Player:CreateButton({
    Name = "Unlock All Islands",
    Callback = function()
      for _, island in pairs(workspace.islandUnlockParts:GetChildren()) do
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, island, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, island, 1)
      end
    end
})



local Section = Player:CreateSection("Player stuff")

local Input = Player:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "16",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = Player:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	_G.SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = Player:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	_G.NoClip = Value
   	NoClip()
   end,
})
local Section = Player:CreateSection("Jump")
local Input = Player:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = Player:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	_G.SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = Player:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	_G.InfJump = Value
   	InfJump()
   end,
})

local TP = Window:CreateTab("Teleports", "shell")
local Section = TP:CreateSection("Spawn")

local Button = TP:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local Player = game.Players.LocalPlayer 

        local character = Player.Character or Player.CharacterAdded:Wait()

        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(-58.8000031, 0.898000002, 30.0600014)
        else
            warn("HumanoidRootPart not found!")
        end
    end
})


local Section = TP:CreateSection("Map Teleports")

local islandNames = {
    "Enchanted Island",
    "Astral Island",
    "Mystical Island",
    "Space Island",
    "Tundra Island",
    "Eternal Island",
    "Sandstorm",
    "Thunderstorm",
    "Ancient Inferno Island",
    "Midnight Shadow Island",
    "Mythical Souls Island",
    "Winter Wonder Island",
    "Golden Master Island",
    "Dragon Legend Island",
    "Cybernetic Legends Island",
    "Skystorm Ultraus Island",
    "Chaos Legends Island",
    "Soul Fusion Island",
    "Inner Peace Island",
    "Blazing Vortex Island"
}

local selectedIsland = nil 

local IslandDropdown = TP:CreateDropdown({
    Name = "Select Island",
    Options = islandNames,
    Callback = function(selected)
        if typeof(selected) == "table" then
            selectedIsland = selected[1]
        elseif typeof(selected) == "string" then
            selectedIsland = selected
        else

            selectedIsland = nil
            print("Error: Dropdown returned an unexpected value type:", typeof(selected))
        end

        if selectedIsland then
            print("Island selected: " .. selectedIsland)
        else
            print("Error: No valid island selected!")
        end
    end
})

local TeleportButton = TP:CreateButton({
    Name = "Teleport to Selected Island",
    Callback = function()
        if not selectedIsland or type(selectedIsland) ~= "string" then
            print("Error: No valid island selected!")
            return
        end

        local islandUnlockParts = game:GetService("Workspace"):FindFirstChild("islandUnlockParts")
        if not islandUnlockParts then
            print("Error: islandUnlockParts not found in Workspace!")
            return
        end

        local island = islandUnlockParts:FindFirstChild(selectedIsland)
        if not island then
            print("Error: Island not found: " .. selectedIsland)
            return
        end

        local touchInterest = island:FindFirstChild("TouchInterest")
        if not touchInterest then
            print("Error: TouchInterest not found for island: " .. selectedIsland)
            return
        end

        local parentPart = island
        if parentPart and parentPart:IsA("BasePart") then
            local playerHead = Plr.Character:WaitForChild("Head")
            Plr.Character:SetPrimaryPartCFrame(parentPart.CFrame)
            print("Teleported to island: " .. selectedIsland)
        else
            print("Error: No valid part to teleport for island: " .. selectedIsland)
        end
    end
})

local Button = TP:CreateButton({
    Name = "Teleport to King Hill",
    Callback = function()
        local Player = game.Players.LocalPlayer 

        local character = Player.Character or Player.CharacterAdded:Wait()

        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(235.907196, 89.8000641, -282.457306)
        else
            warn("HumanoidRootPart not found!")
        end
    end
})

local Section = TP:CreateSection("Other Locations")

local Button = TP:CreateButton({
    Name = "Teleport to Pet Cloner",
    Callback = function()
        local Player = game.Players.LocalPlayer 

        local character = Player.Character or Player.CharacterAdded:Wait()

        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(4578.66553, 130.646988, 1426.25061)
        else
            warn("HumanoidRootPart not found!")
        end
    end
})

local Pet = Window:CreateTab("Pets", "paw-print")
local Section = Pet:CreateSection("Auto stuff")

local crystalTypes = {
    "Blue Crystal",
    "Purple Crystal",
    "Enchanted Crystal",
    "Astral Crystal",
    "Golden Crystal",
    "Inferno Crystal",
    "Galaxy Crystal",
    "Frozen Crystal",
    "Eternal Crystal",
    "Storm Crystal",
    "Thunder Crystal",
    "Secret Blades Crystal",
    "Infinity Void Crystal"
}

local selectedCrystal = "Blue Crystal"  

local CrystalDropdown = Pet:CreateDropdown({
    Name = "Select Crystal",
    Options = crystalTypes,
    CurrentOption = selectedCrystal,
    Callback = function(Value)
        if type(Value) == "table" then
            selectedCrystal = Value[1] or "Blue Crystal"
        else
            selectedCrystal = Value
        end
        print("Selected crystal changed to: " .. tostring(selectedCrystal))
    end
})

local crystalCosts = {
    ["Blue Crystal"] = 1000,
    ["Purple Crystal"] = 2000,
    ["Enchanted Crystal"] = 6000,
    ["Astral Crystal"] = 10000,
    ["Golden Crystal"] = 15000,
    ["Inferno Crystal"] = 40000,
    ["Galaxy Crystal"] = 75000,
    ["Frozen Crystal"] = 300000,
    ["Eternal Crystal"] = 600000,
    ["Storm Crystal"] = 1500000,
    ["Thunder Crystal"] = 8000000,
    ["Secret Blades Crystal"] = 55000000000, 
    ["Infinity Void Crystal"] = 5000000000000 
}

local function openCrystal()
    local args = {
        [1] = "openCrystal",
        [2] = selectedCrystal
    }
    local success, result = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(unpack(args))
    end)
    if success then
        if result == nil then

            local playerChi = game.Players.LocalPlayer.Chi.Value 
            local crystalCost = crystalCosts[selectedCrystal] or 0
            
            if playerChi < crystalCost then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Insufficient Chi",
                    Text = "You need " .. tostring(crystalCost) .. " Chi to open " .. tostring(selectedCrystal),
                    Duration = 5
                })
            end
            return false
        else
            print("Opened " .. tostring(selectedCrystal) .. ". Result: " .. tostring(result))
            return true
        end
    else
        warn("Failed to open " .. tostring(selectedCrystal) .. ". Error: " .. tostring(result))
        return false
    end
end


local OpenCrystalButton = Pet:CreateButton({
    Name = "Open Crystal Once",
    Callback = function()
        openCrystal()
    end
})

local ToggleAutoCrystal = Pet:CreateToggle({
    Name = "Auto Open Crystal",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoOpenCrystal = state
        
        if state then
            print("Auto Open Crystal enabled for: " .. tostring(selectedCrystal))
            task.spawn(function()
                while getgenv().AutoOpenCrystal do
                    local opened = openCrystal()
                    if not opened then
                        task.wait(1.5)
                    else
                        task.wait(1)
                    end
                end
            end)
        else
            print("Auto Open Crystal disabled")
        end
    end
})

local ToggleAutoEvolve = Pet:CreateToggle({
    Name = "Auto Evolve",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoEvolve = state

        if state then
            coroutine.wrap(function()
                while getgenv().AutoEvolve do
                    local ohString1 = "autoEvolvePets"
                    game:GetService("ReplicatedStorage").rEvents.autoEvolveRemote:InvokeServer(ohString1)
                    wait(1)  
                end
            end)()
        else
            getgenv().AutoEvolve = false
        end
    end
})


local Section = Pet:CreateSection("Sell")

local petTypes = {
    "Basic", "Advanced", "Rare", "Epic", "Unique", "Omega", "Elite", "Infinity", 
    "Awakened", "Master Legend", "BEAST", "Skystorm", "Soul Master", "Rising Hero", 
    "Q-STRIKE", "Skyblade"
}

getgenv().PetToSell = "Basic" 

local PetSellDropdown = Pet:CreateDropdown({
    Name = "Select Pet to Sell",
    Options = petTypes,
    CurrentOption = "Basic",
    Flag = "PetToSell",
    Callback = function(Value)
        if type(Value) == "table" then
            getgenv().PetToSell = Value[1] 
        else
            getgenv().PetToSell = Value
        end
        print("Selected pet type to sell: " .. tostring(getgenv().PetToSell))
    end
})

local AutoSellToggle = Pet:CreateToggle({
    Name = "Auto Sell Selected Pets",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoSellPets = state
        
        if state then
            task.spawn(function()
                while getgenv().AutoSellPets do
                    local Plr = game.Players.LocalPlayer
                    if not getgenv().PetToSell or getgenv().PetToSell == "" then
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "Error",
                            Text = "Please select a pet type to sell first",
                            Duration = 5
                        })
                        getgenv().AutoSellPets = false
                        break
                    end

                    local petsSold = 0
                    for i, pet in pairs(Plr.petsFolder[getgenv().PetToSell]:GetChildren()) do
                        game:GetService("ReplicatedStorage").rEvents.sellPetEvent:FireServer("sellPet", pet)
                        petsSold = petsSold + 1
                    end

                    if petsSold > 0 then
                        print("Sold " .. petsSold .. " " .. getgenv().PetToSell .. " pets")
                    else
                        print("No " .. getgenv().PetToSell .. " pets found to sell")
                    end

                    task.wait(1) 
                end
            end)
        else
            getgenv().AutoSellPets = false
            print("Auto Sell Pets disabled")
        end
    end
})

local Boss = Window:CreateTab("Boss", "bot")
local Section = Boss:CreateSection("Boss")

local Player = game.Players.LocalPlayer
local TeleportToggle = Boss:CreateToggle({
    Name = "Auto Fight Robot Boss",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoTeleportToBoss = state
        
        if state then
            print("Auto Teleport enabled")
            getgenv().AutoSwing = true 
            AutoSwing()
            task.spawn(function()
                while getgenv().AutoTeleportToBoss do
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPart = workspace:FindFirstChild("bossFolder") and workspace.bossFolder:FindFirstChild("RobotBoss") and workspace.bossFolder.RobotBoss:FindFirstChild("LeftLowerLeg")
                        
                        if targetPart then
                            Player.Character.HumanoidRootPart.CFrame = targetPart.CFrame
                        else
                            print("Target part not found!")
                            break 
                        end
                    else
                        task.wait(0.1) 
                    end

                    task.wait(0.1) 
                end
                getgenv().AutoSwing = false 
            end)
        else
            print("Auto Teleport disabled")
            getgenv().AutoSwing = false 
        end
    end
})

local TeleportToggle = Boss:CreateToggle({
    Name = "Auto Fight Eternal Boss",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoTeleportToBoss = state
        
        if state then
            print("Auto Teleport enabled")
            getgenv().AutoSwing = true 
            AutoSwing() 

            task.spawn(function()
                while getgenv().AutoTeleportToBoss do
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPart = workspace:FindFirstChild("bossFolder") and workspace.bossFolder:FindFirstChild("EternalBoss") and workspace.bossFolder.EternalBoss:FindFirstChild("LeftLowerLeg")
                        
                        if targetPart then
                            Player.Character.HumanoidRootPart.CFrame = targetPart.CFrame
                        else
                            print("Target part not found!")
                            break 
                        end
                    else
                        task.wait(0.1) 
                    end

                    task.wait(0.1) 
                end
                
                getgenv().AutoSwing = false 
            end)
        else
            print("Auto Teleport disabled")
            getgenv().AutoSwing = false 
        end
    end
})

local TeleportToggle = Boss:CreateToggle({
    Name = "Auto Fight Ancient Magma Boss",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoTeleportToBoss = state
        
        if state then
            print("Auto Teleport enabled")
            getgenv().AutoSwing = true 
            AutoSwing() 

            task.spawn(function()
                while getgenv().AutoTeleportToBoss do
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPart = workspace:FindFirstChild("bossFolder") and workspace.bossFolder:FindFirstChild("AncientMagmaBoss") and workspace.bossFolder.AncientMagmaBoss:FindFirstChild("LeftUpperLeg")
                        
                        if targetPart then
                            Player.Character.HumanoidRootPart.CFrame = targetPart.CFrame
                        else
                            print("Target part not found!")
                            break 
                        end
                    else
                        task.wait(0.1) 
                    end

                    task.wait(0.1) 
                end
                
                getgenv().AutoSwing = false 
            end)
        else
            print("Auto Teleport disabled")
            getgenv().AutoSwing = false 
        end
    end
})

local Misc = Window:CreateTab("Misc", "swatch-book")
local Section = Misc:CreateSection("Misc")

local ToggleAutoDuel = Misc:CreateToggle({
    Name = "Auto Join Duels",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoJoinDuels = state
        
        if state then
            task.spawn(function()
                while getgenv().AutoJoinDuels do
                    local args = {
                        [1] = "joinDuel"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("duelEvent"):FireServer(unpack(args))
                    
                    task.wait(3) 
                end
            end)
        end
    end
})

local OWN = Window:CreateTab("Script Writer")
local Section = OWN:CreateSection("Writer")

local Label = OWN:CreateLabel("PrismX - Ninja Legends Script Writer",SectionParent)
