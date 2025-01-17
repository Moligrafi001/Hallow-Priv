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

-- Globals
getgenv().NL_Config = NL_Config
getgenv().AutoSwing = false
getgenv().AutoSell = false
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


local Menu = Window:CreateTab("Main", "square-function")
local AutofarmSection = Menu:CreateSection("Main Features")

local AutoSwingConnection
local ToggleSwing = Menu:CreateToggle({
    Name = "Auto Swing",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoSwing = state
        if state then
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

                    NinjaEvent:FireServer("swingKatana")
                    task.wait(tonumber(getgenv().SwingDelay) or 0)
                end
            end)
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
                    -- Get the player's current rank
                    local currentRank = Plr.leaderstats.Rank.Value

                    -- Find the next rank in the list
                    local nextRankIndex = table.find(ranks, currentRank) + 1
                    local nextRank = ranks[nextRankIndex]

                    if not nextRank then
                        print("All ranks purchased!")
                        break
                    end

                    -- Attempt to buy the next rank
                    local args = {
                        [1] = "buyRank",
                        [2] = nextRank
                    }

                    -- Fire the event to purchase the rank
                    pcall(function()
                        game:GetService("Players").LocalPlayer:WaitForChild("ninjaEvent"):FireServer(unpack(args))
                    end)

                    task.wait(1) -- Wait 1 second before trying again
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
    "MythicalChest",
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
    Name = "Unlock All Chests",
    CurrentValue = false,
    Callback = function(state)
        getgenv().UnlockAllChests = state
        
        if state then
            -- Enable Infinite Jump when Unlock All Chests is toggled on
            InfJump(true)

            task.spawn(function()
                for _, chestName in ipairs(chestNames) do
                    if not getgenv().UnlockAllChests then break end

                    -- Locate the chest folder in the workspace
                    local chestFolder = game:GetService("Workspace"):FindFirstChild(chestName)
                    if chestFolder then
                        -- Locate the circleOuter part inside the chest folder
                        local circleOuterPart = chestFolder:FindFirstChild("circleOuter")
                        if circleOuterPart and circleOuterPart:IsA("BasePart") then
                            -- Move the player forward in 3 steps
                            local humanoidRootPart = Plr.Character:WaitForChild("HumanoidRootPart")
                            local moveDirection = humanoidRootPart.CFrame.LookVector * 50 -- Adjust multiplier for speed

                            for step = 1, 3 do
                                humanoidRootPart.Velocity = moveDirection
                                wait(1) -- Wait for 1 second per step
                            end
                            humanoidRootPart.Velocity = Vector3.zero -- Stop movement

                            -- Teleport the player to the circleOuter part
                            Plr.Character:SetPrimaryPartCFrame(circleOuterPart.CFrame)

                            -- Wait for stability
                            wait(0.5)

                            -- Invoke the remote to unlock the chest
                            local args = { [1] = chestName }
                            local success, err = pcall(function()
                                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("checkChestRemote"):InvokeServer(unpack(args))
                            end)

                            if success then
                                print("Successfully unlocked chest: " .. chestName)
                            else
                                warn("Failed to unlock chest: " .. chestName .. " | Error: " .. tostring(err))
                            end

                            wait(1) -- Ensure time before moving to the next chest
                        else
                            warn("circleOuter part not found inside " .. chestName)
                        end
                    else
                        warn("Chest folder not found for: " .. chestName)
                    end
                end
            end)
        else
            -- Disable Infinite Jump when Unlock All Chests is toggled off
            InfJump(false)
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

local Section = Player:CreateSection("Weapon & Belt")

if not getgenv().NL_Config then
    getgenv().NL_Config = {
        BuySwords = false,
        BuyBelts = false,
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

-- Toggle for Auto Purchase Swords
local TogglePurchaseSwords = Player:CreateToggle({
    Name = "Auto Purchase Swords",
    CurrentValue = Config.BuySwords,  -- Set the initial value based on Config
    Callback = function(state)
        Config.BuySwords = state  -- Update Config with the current toggle state
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
local TogglePurchaseBelts = Player:CreateToggle({
    Name = "Auto Purchase Belts",
    CurrentValue = Config.BuyBelts,  -- Set the initial value based on Config
    Callback = function(state)
        Config.BuyBelts = state  -- Update Config with the current toggle state
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


local Pet = Window:CreateTab("Pets", "paw-print")
local Section = Pet:CreateSection("Auto stuff")

local DropdownCrystal = Pet:CreateDropdown({
    Name = "Chosen Crystal:",
    Info = "Crystal to hatch pets from.",
    Options = {
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
    },
    CurrentOption = getgenv().CrystalToHatch, 
    Callback = function(currentOption)
        getgenv().CrystalToHatch = currentOption
        

        if getgenv().AutoHatch then
            getgenv().AutoHatch = false 
            task.wait(0.1)  
            getgenv().AutoHatch = true   
        end
    end
})

local ToggleAutoHatch = Pet:CreateToggle({
    Name = "Auto Hatch",
    CurrentValue = false,
    Callback = function(state)
        if state then
            getgenv().AutoHatch = true

            while getgenv().AutoHatch do
                pcall(function()
                    local args = {
                        [1] = "openCrystal",
                        [2] = getgenv().CrystalToHatch
                    }

                    game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer(unpack(args))
                end)
             end
        else
            getgenv().AutoHatch = false
        end
    end
})

local ToggleAutoEvolve = Pet:CreateToggle({
    Name = "Auto Evolve",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoEvolve = state

        if state then
            while getgenv().AutoEvolve do
                pcall(function()
                    for i, type in pairs(Plr.petsFolder:GetChildren()) do
                        for i2, pet in pairs(type:GetChildren()) do
                            local evolutionOrder = "evolved"  
                            game:GetService("ReplicatedStorage").rEvents.petNextEvolutionEvent:FireServer("evolvePet", pet, game:GetService("ReplicatedStorage").evolutionOrders[evolutionOrder])
                        end
                    end
                end)

                wait(1)
            end
        else
            getgenv().AutoEvolve = false
        end
    end
})

local CreditsTab = Window:CreateTab("Credits")
-- Credits
CreditsTab:CreateSection("Founder Developer")
CreditsTab:CreateLabel("Discord: moligrafi")
CreditsTab:CreateSection("Main Developer")
CreditsTab:CreateLabel("Discord: _prismx")
CreditsTab:CreateSection("Discord Server")
CreditsTab:CreateLabel("discord.gg/AESCuek87s")
CreditsTab:CreateButton({
    Name = "Copy Server Link",
    Callback = function()
        setclipboard("discord.gg/AESCuek87s")
    end
})
CreditsTab:CreateLabel("If you find any bug join the discord and open a ticket")


