-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/PetStarSim.lua",true))()
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
getgenv().SelectedEgg = nil
_G.selectedMap = nil
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

        for _, star in ipairs(stars) do
            local primaryPart = star:FindFirstChild("Primary")
            if primaryPart and primaryPart:IsA("BasePart") then
                local touchInterest = primaryPart:FindFirstChild("TouchInterest")
                if touchInterest and touchInterest:IsA("TouchTransmitter") then
                    -- Simulate touch event with the TouchInterest
                    if touchInterest and touchInterest.Parent then
                        firetouchinterest(character.HumanoidRootPart, touchInterest.Parent, 0)
                        task.wait()  -- Use task.wait() for a shorter, more consistent wait
                        if touchInterest and touchInterest.Parent then
                            firetouchinterest(character.HumanoidRootPart, touchInterest.Parent, 1)
                            
                            print("Touched star's TouchInterest in map " .. mapName .. ": " .. star.Name)

                            local collectStarRemote = ReplicatedStorage:FindFirstChild("Core") and ReplicatedStorage.Core:FindFirstChild("Remote") and ReplicatedStorage.Core.Remote:FindFirstChild("collectStar")
                            if collectStarRemote then
                                collectStarRemote:FireServer(star)  
                                print("Collected star: " .. star.Name)
                            else
                                warn("RemoteEvent 'collectStar' not found in ReplicatedStorage.Core.Remote!")
                            end
                        end
                    end
                    
                    task.wait(0.05)
                else
                    warn("TouchInterest not found in Primary part of star: " .. star.Name)
                end
            else
                warn("Primary part not found in star: " .. star.Name)
            end
        end

        task.wait(0.01) 
    end

    isAutoCollecting = false
end


local function teleport(location, title, message)
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character.HumanoidRootPart
    humanoidRootPart.CFrame = location

    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = 5
    })
end

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


local mapPositions = {
    ["SPAWN"] = CFrame.new(13.6210747, 4.00057125, -563.520813, 0.847098291, -9.54145136e-08, 0.531436265, 7.91322776e-08, 1, 5.34056461e-08, -0.531436265, -3.1860703e-09, 0.847098291),
    ["Autumn Forest"] = CFrame.new(9.3673954, 3.9999578, -758.91449, 0.999615431, 3.39384449e-08, -0.0277317464, -3.39598323e-08, 1, -3.00279579e-10, 0.0277317464, 1.24192956e-09, 0.999615431),
    ["Flower Garden"] = CFrame.new(8.04845238, 3.9999578, -954.51532, 0.85444808, 4.35373231e-08, -0.519536793, -3.85188983e-08, 1, 2.04507611e-08, 0.519536793, 2.53787125e-09, 0.85444808),
    ["Snow Forest"] = CFrame.new(8.96513653, 4.01302624, -1148.30078, 0.999520063, 4.09274143e-08, 0.0309788994, -4.40184849e-08, 1, 9.9097953e-08, -0.0309788994, -1.00414034e-07, 0.999520063),
    ["Tropical Palms"] = CFrame.new(9.11476231, 4.00638866, -1343.58887, 0.994337261, 1.19500756e-08, 0.106270239, -1.67945888e-08, 1, 4.469182e-08, -0.106270239, -4.62235086e-08, 0.994337261),
    ["Mine Shaft"] = CFrame.new(9.55875301, 3.9999578, -1539.07959, 0.998662055, 1.6683753e-08, 0.0517115854, -1.9181174e-08, 1, 4.77989346e-08, -0.0517115854, -4.87268714e-08, 0.998662055),
    ["Diamond Mine"] = CFrame.new(8.39960861, 3.9999578, -1733.69385, 0.999885857, -1.27159751e-07, -0.0151077257, 1.2689209e-07, 1, -1.86757685e-08, 0.0151077257, 1.67565855e-08, 0.999885857),
    ["Magical Forest"] = CFrame.new(8.94233418, 3.9999578, -1931.28259, 0.999978125, -7.19709403e-10, 0.00661586365, 8.80404194e-10, 1, -2.42863987e-08, -0.00661586365, 2.42916922e-08, 0.999978125),
    ["Sakura Forest"] = CFrame.new(9.63525772, 3.9999578, -2126.64038, 0.998708427, -4.76508255e-09, 0.0508081615, 3.2844083e-10, 1, 8.73297878e-08, -0.0508081615, -8.72003056e-08, 0.998708427),
    ["Sakura Ravine"] = CFrame.new(10.4414206, 3.99438834, -2321.14819, 0.997639, 5.84764166e-08, -0.0686761737, -6.19572944e-08, 1, -4.85553642e-08, 0.0686761737, 5.26957145e-08, 0.997639),
    ["Magma Ravine"] = CFrame.new(8.24645805, 3.97864127, -2515.40601, 0.999063671, -2.30366226e-10, -0.0432639308, 4.2857784e-10, 1, 4.57217642e-09, 0.0432639308, -4.58643745e-09, 0.999063671),
    ["Cloud Road"] = CFrame.new(8.24593353, 3.97864127, -2521.6958, 0.380393147, -3.80988112e-08, 0.924824893, 1.88804683e-09, 1, 4.0419124e-08, -0.924824893, -1.36290446e-08, 0.380393147),
    ["Heaven"] = CFrame.new(8.67521954, 3.99617362, -2712.61621, 0.99999994, -3.22287153e-09, -0.000329909031, 3.19627369e-09, 1, -8.06222431e-08, 0.000329909031, 8.06211844e-08, 0.99999994),
}

local function TeleportMap()
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    if character and character:FindFirstChild("HumanoidRootPart") then
        if selectedMap == nil then
            Rayfield:Notify({
                Title = "No Map selected.",
                Content = "You have to select it before you teleport.",
                Duration = 2.5,
                Image = 17091459839,
            })
            return 
        end

        local teleportPosition = mapPositions[selectedMap]
        if teleportPosition then
            character.HumanoidRootPart.CFrame = teleportPosition
            Rayfield:Notify({
                Title = selectedMap,
                Content = "Teleported to " .. selectedMap .. "!",
                Duration = 2.5,
                Image = 17091459839,
            })
        end
    end
end

local function autoOpenEgg(eggType)
    local args = {
        [1] = eggType,
        [2] = "Auto Open"
    }

    local hatchRemote = game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remote"):WaitForChild("Hatch")
    
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if self == hatchRemote and method == "InvokeServer" then
            return true
        end
        
        return oldNamecall(self, ...)
    end)

    hatchRemote:InvokeServer(unpack(args))
end
local isAutoHatching = false

local function stopAllAutoHatches()
    isAutoHatching = false
    getgenv().AutoHatch = false
end

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Variables to manage toggle state
local antiLagEnabled = false
local monitorThread
local originalPlayerGuiStates = {}

-- Reduce Graphics Settings
local function reduceGraphics()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1000
    Lighting.Brightness = 1


    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = false
        end
    end


    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CastShadow = false
            if obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                obj.RenderFidelity = Enum.RenderFidelity.Automatic
            end
        end
    end
end

local function resetGraphics()
    Lighting.GlobalShadows = true
    Lighting.FogEnd = 100000
    Lighting.Brightness = 2

    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect.Enabled = true
        end
    end

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CastShadow = true
            if obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                obj.RenderFidelity = Enum.RenderFidelity.Precise
            end
        end
    end
end

local function disablePlayerHUD()
    local player = Players.LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        local scriptsFolder = playerGui:FindFirstChild("Scripts")
        if scriptsFolder then
            local hudMain = scriptsFolder:FindFirstChild("HUD Main") 
            if hudMain and hudMain:IsA("Script") then
                originalPlayerGuiStates[player] = originalPlayerGuiStates[player] or {}
                originalPlayerGuiStates[player]["HUD Main"] = hudMain.Disabled
                -- Disable the script
                hudMain.Disabled = true
                print("HUD Main script has been disabled")  
            else
                print("HUD Main script not found or is not a Script") 
            end
        else
            print("Scripts folder not found in PlayerGui") 
        end
    end
end

local function restorePlayerHUD()
    local player = Players.LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        local scriptsFolder = playerGui:FindFirstChild("Scripts") 
        if scriptsFolder then
            local hudMain = scriptsFolder:FindFirstChild("HUD Main") 
            if hudMain and hudMain:IsA("Script") and originalPlayerGuiStates[player] and originalPlayerGuiStates[player]["HUD Main"] ~= nil then
                hudMain.Disabled = originalPlayerGuiStates[player]["HUD Main"]
                print("HUD Main script has been restored")  
            else
                print("HUD Main script not found or no previous state to restore")  
            end
        else
            print("Scripts folder not found in PlayerGui")  
        end
    end
end


local function monitorPerformance()
    while antiLagEnabled do
        reduceGraphics()
        disablePlayerHUD()  
        print("Anti-Lag active. Memory usage (KB):", collectgarbage("count"))
        wait(5)
    end
end

local function initAntiLag(enabled)
    antiLagEnabled = enabled

    if enabled then
        monitorThread = coroutine.create(monitorPerformance)
        coroutine.resume(monitorThread)

        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-Lag Enabled",
            Text = "Optimizations are now active.",
            Duration = 5,
        })
    else
        if monitorThread then
            coroutine.close(monitorThread)
            monitorThread = nil
        end

        resetGraphics()
        restorePlayerHUD() 

        game.StarterGui:SetCore("SendNotification", {
            Title = "Anti-Lag Disabled",
            Text = "Graphics settings restored to default.",
            Duration = 5,
        })
    end
end

	
local Menu = Window:CreateTab("Main", "home")
local Divider = Menu:CreateDivider()
local Toggle = Menu:CreateToggle({
   Name = "Anti-Lag",
   CurrentValue = false,
   Flag = "Toggleanti1",
   Callback = function(Value)
        initAntiLag(Value)
   end,
})
local Divider = Menu:CreateDivider()
local Section = Menu:CreateSection("Auto collect stars")

local ToggleEnabled = false 

local Dropdown = Menu:CreateDropdown({
    Name = "Select Map (If not unlocked it will NOT work.)",
    Options = {"SPAWN", "Autumn Forest", "Flower Garden", "Snow Forest", "Tropical Palms", "Mine Shaft", "Diamond Mine", "Magical Forest", "Sakura Forest", "Sakura Ravine", "Magma Ravine", "Cloud Road", "Heaven"},
    CurrentOption = {"SPAWN"},
    MultipleOptions = false,
    Callback = function(Options)
        if getgenv().AutoColStars then 
            Rayfield:Notify({
                Title = "Action Blocked",
                Content = "Cannot change the map while Auto Collect Stars is enabled. Please disable it first.",
                Duration = 2.5,
                Image = 17091459839,
            })
            return
        end

        selectedMap = Options[1]
        TeleportMap()
    end,
})


local Section = Menu:CreateSection("PICK MAP FIRST BEFORE TOGGLEING ON!!!!!!!!!!")


local Toggle = Menu:CreateToggle({
    Name = "Toggle Auto Collect Stars",
    CurrentValue = false,
    Flag = "AutoCollectStarsToggle",
    Callback = function(Value)
        getgenv().AutoColStars = Value
        if Value then
            AutoCollectStars(selectedMap)
        else
            isAutoCollecting = false
        end
    end
})

local Section = Menu:CreateSection("Player", "person-standing")

local Input = Menu:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "16",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	_G.SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	_G.NoClip = Value
   	NoClip()
   end,
})
local Section = Menu:CreateSection("Jump")
local Input = Menu:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	_G.SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	_G.InfJump = Value
   	InfJump()
   end,
})


local TP = Window:CreateTab("Teleports", "shell")
local Section = TP:CreateSection("Egg Teleports")

local selectedEgg = nil

local function Teleport()
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    if character and character:FindFirstChild("HumanoidRootPart") then
        if selectedEgg == nil then
            Rayfield:Notify({
                Title = "No egg selected.",
                Content = "You have to select it before you teleport.",
                Duration = 2.5,
                Image = 17091459839,
            })
            return 
        end

        local teleportPosition
        if selectedEgg == "Basic Egg" then
            teleportPosition = CFrame.new(72.3426514, 4.49999952, -617.722229)
        elseif selectedEgg == "Autumn Egg" then
            teleportPosition = CFrame.new(72.9331055, 4.49999952, -808.936035)
        elseif selectedEgg == "Bee Egg" then
            teleportPosition = CFrame.new(72.6726074, 4.49999952, -1007.59424)
        elseif selectedEgg == "Snow Egg" then
            teleportPosition = CFrame.new(70.7977753, 4.49999952, -1200.2113)
        elseif selectedEgg == "Tropical Egg" then
            teleportPosition = CFrame.new(72.4018021, 4.49999952, -1392.255)
        elseif selectedEgg == "Mine Egg" then
            teleportPosition = CFrame.new(72.2127914, 4.49999952, -1586.75415)
        elseif selectedEgg == "Diamond Egg" then
            teleportPosition = CFrame.new(70.951973, 4.49999952, -1785.34338)
        elseif selectedEgg == "Magical Egg" then
            teleportPosition = CFrame.new(73.3748856, 4.49999952, -1979.67188)
        elseif selectedEgg == "Sakura Egg" then
            teleportPosition = CFrame.new(71.8911285, 4.49999952, -2173.75244)
        elseif selectedEgg == "Split Egg" then
            teleportPosition = CFrame.new(71.7752457, 4.50232172, -2372.65015)
        elseif selectedEgg == "Devil Egg" then
            teleportPosition = CFrame.new(72.6531219, 4.50232172, -2563.57422)
        elseif selectedEgg == "Cloud Egg" then
            teleportPosition = CFrame.new(72.6568451, 4.50232172, -2762.99146)
        elseif selectedEgg == "Heaven Egg" then
            teleportPosition = CFrame.new(73.6565552, 4.50232172, -2957.67847)
        end

        character.HumanoidRootPart.CFrame = teleportPosition
        Rayfield:Notify({
            Title = selectedEgg,
            Content = "Teleported to " .. selectedEgg .. "!",
            Duration = 2.5,
            Image = 17091459839,
        })
    end
end

TP:CreateDropdown({
    Name = "Select Egg",
    Options = {
        "Basic Egg",
        "Autumn Egg",
        "Bee Egg",
        "Snow Egg",
        "Tropical Egg",
        "Mine Egg",
        "Diamond Egg",
        "Magical Egg",
        "Sakura Egg",
        "Split Egg",
        "Devil Egg",
        "Cloud Egg",
        "Heaven Egg"
    },
    CurrentOption = "Basic Egg",
    MultipleOptions = false,
    Callback = function(Options)
        selectedEgg = Options[1]  
        Teleport()  
    end,
})
local Section = TP:CreateSection("Map Teleports")

local Dropdown = TP:CreateDropdown({
    Name = "Map Teleports",
    Options = {"SPAWN", "Autumn Forest", "Flower Garden", "Snow Forest", "Tropical Palms", "Mine Shaft", "Diamond Mine", "Magical Forest", "Sakura Forest", "Sakura Ravine", "Magma Ravine", "Cloud Road", "Heaven"},
    CurrentOption = {"SPAWN"},
    MultipleOptions = false,
    Callback = function(Options)
        if getgenv().AutoColStars then 
            Rayfield:Notify({
                Title = "Action Blocked",
                Content = "You messed somthing up",
                Duration = 2.5,
                Image = 17091459839,
            })
            return
        end

        selectedMap = Options[1]
        TeleportMap()
    end,
})

local Pet = Window:CreateTab("Pets", "bone")
local Section = Pet:CreateSection("Auto Hatch")