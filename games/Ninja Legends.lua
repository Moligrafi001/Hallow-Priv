local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Ninja Legends⭐",
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi & PrismX",
    Theme = "Amethyst"
})

local Plr = game:GetService("Players").LocalPlayer
local NinjaEvent = Plr:FindFirstChild("ninjaEvent")

-- Globals
getgenv().AutoSwing = false
getgenv().AutoSell = false
getgenv().AutoHatch = false
getgenv().AutoEvolve = false
getgenv().SwingDelay = "0.5"
getgenv().FarmHoops = false
getgenv().AutoPurchaseSwords = false
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
                local GroundBelts = game:GetService("ReplicatedStorage").Belts.Ground
                local CurrentBelt = Plr.equippedBelt.Value

                if CurrentNinjitsu.Value <= GroundBelts[CurrentBelt.Name].capacity.Value then
                    local sellPart = game:GetService("Workspace").sellAreaCircles.sellAreaCircle.circleInner
                    firetouchinterest(sellPart, Plr.Character.Head, 1)
                    task.wait(0.5)
                    firetouchinterest(sellPart, Plr.Character.Head, 0)
                end
            end)
        end
    end
})

local AutoSellConnection = nil 

local ToggleSell = Menu:CreateToggle({
    Name = "Auto Sell (When bags full)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoSell = state


        if not state then
            AutoSellConnection = nil
        end

        if state then
            AutoSellConnection = Plr.leaderstats.Ninjitsu:GetPropertyChangedSignal("Value"):Connect(function()
                local CurrentNinjitsu = Plr.leaderstats.Ninjitsu
                local GroundBelts = game:GetService("ReplicatedStorage").Belts.Ground
                local CurrentBelt = Plr.equippedBelt.Value

                if CurrentNinjitsu.Value >= GroundBelts[CurrentBelt.Name].capacity.Value then
                    local sellPart = game:GetService("Workspace").sellAreaCircles.sellAreaCircle.circleInner
                    firetouchinterest(sellPart, Plr.Character.Head, 1)
                    task.wait(0.5)
                    firetouchinterest(sellPart, Plr.Character.Head, 0)
                end
            end)
        end
    end
})

local AutofarmSection = Menu:CreateSection("Other")

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

local ToggleUnlockIslands = Player:CreateToggle({
    Name = "Unlock All Islands",
    CurrentValue = false,
    Callback = function(state)
        getgenv().UnlockAllIslands = state
        if state then
            task.spawn(function()
                local islandUnlockParts = game:GetService("Workspace").islandUnlockParts -- This is where your islands' unlock parts are stored
                
                -- List of island names to iterate through in order
                local islandNames = {
                    "Enchanted Island",
                    "Astral Island",
                    "Mystical Island",
                    "Space Island",
                    "Tundra Island",
                    "Eternal Island",
                    "Sandstorm",
                    "Thunderstorm Island",
                    "Ancient Inferno Island",
                    "Thunderstorm",
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

                -- Iterate over each island's name
                for _, islandName in ipairs(islandNames) do
                    if not getgenv().UnlockAllIslands then break end
                    
                    -- Find the specific unlock part for each island
                    local island = islandUnlockParts:FindFirstChild(islandName)
                    if island then
                        local touchInterest = island:FindFirstChild("TouchInterest") -- Get the TouchInterest part
                        if touchInterest then
                            local parentPart = island -- The parent part is the one containing TouchInterest, which is a BasePart
                            if parentPart and parentPart:IsA("BasePart") then
                                -- Teleport the player to the parent part (the part containing TouchInterest)
                                local playerHead = Plr.Character:WaitForChild("Head")
                                Plr.Character:SetPrimaryPartCFrame(parentPart.CFrame) -- Teleport to the part
                                wait(0.2) -- Delay before moving to the next island
                            else
                                warn("No valid part found for island " .. islandName)
                            end
                        else
                            warn("No TouchInterest found in " .. islandName)
                        end
                    else
                        warn("No unlock part found for " .. islandName)
                    end
                end
            end)
        end
    end
})

local Section = Player:CreateSection("Weapon & Belt")

local Dropdown = Player:CreateDropdown({
    Name = "Select Island for auto weapon/belt",
    Options = { 
        "Ground", 
        "Astral Island", 
        "Space Island", 
        "Tundra Island", 
        "Eternal Island", 
        "Sandstorm", 
        "Thunderstorm Island", 
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
    },
    CurrentOption = "Ground", 
    Callback = function(currentOption)
        getgenv().IslandToPurchaseFrom = currentOption
    end
})

local TogglePurchaseSwords = Player:CreateToggle({
    Name = "Auto Purchase Swords",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoPurchaseSwords = state
        if state then
            task.spawn(function()
                while getgenv().AutoPurchaseSwords do
                    pcall(function()
                        NinjaEvent:FireServer("buyAllSwords", getgenv().IslandToPurchaseFrom)
                    end)
                    task.wait(0.5) 
                end
            end)
        end
    end
})

local TogglePurchaseBelts = Player:CreateToggle({
    Name = "Auto Purchase Belts",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoPurchaseBelts = state
        if state then
            task.spawn(function()
                while getgenv().AutoPurchaseBelts do
                    pcall(function()
                        NinjaEvent:FireServer("buyAllBelts", getgenv().IslandToPurchaseFrom)
                    end)
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