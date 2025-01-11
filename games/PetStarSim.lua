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

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local isAutoCollecting = false
local currentMap = "SPAWN"
local selectedMap = "SPAWN"

local function AutoCollectStars(selectedMap)
    if isAutoCollecting then
        print("Already collecting on map " .. (currentMap or "unknown") .. ", stopping current collection.")
        return
    end

    selectedMap = selectedMap or "SPAWN"
    currentMap = selectedMap
    isAutoCollecting = true

    while getgenv().AutoColStars do
        local localStars = Workspace:FindFirstChild("LocalStars")
        if not localStars then
            warn("LocalStars folder not found in Workspace!")
            task.wait(0.5)
            continue
        end

        local spawnFolder = localStars:FindFirstChild(selectedMap)
        if not spawnFolder then
            warn("Map " .. selectedMap .. " or corresponding folder not found in LocalStars!")
            task.wait(0.5)
            continue
        end

        local stars = spawnFolder:GetChildren()
        if #stars == 0 then
            warn("No stars found in the folder for map: " .. selectedMap)
            task.wait(0.5)
            continue
        end

        for _, star in ipairs(stars) do
            local primaryPart = star:FindFirstChild("Primary")
            if primaryPart and primaryPart:IsA("BasePart") then
                local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                    primaryPart.CFrame = humanoidRootPart.CFrame

                    firetouchinterest(humanoidRootPart, primaryPart, 0)
                    task.wait(0.1)
                    firetouchinterest(humanoidRootPart, primaryPart, 1)

                    print("Simulated touch with star: " .. star.Name)

                    local collectStarRemote = ReplicatedStorage:FindFirstChild("Core")
                        and ReplicatedStorage.Core:FindFirstChild("Remote")
                        and ReplicatedStorage.Core.Remote:FindFirstChild("collectStar")
                    if collectStarRemote then
                        collectStarRemote:FireServer(star)
                        print("Collected star: " .. star.Name)
                    else
                        warn("RemoteEvent 'collectStar' not found!")
                    end

                    task.wait(0.1)
                else
                    warn("HumanoidRootPart not found for the player!")
                end
            else
                warn("No valid 'Primary' part found in star: " .. star.Name)
            end
        end
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

local selectedMap = nil

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

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto collect stars")

local ToggleEnabled = false 

local Dropdown = Menu:CreateDropdown({
    Name = "Select Map (If not unlocked it will NOT work.)",
    Options = {"SPAWN", "Autumn Forest", "Flower Garden", "Snow Forest", "Tropical Palms", "Mine Shaft", "Diamond Mine", "Magical Forest", "Sakura Forest"},
    CurrentOption = {"SPAWN"},
    MultipleOptions = false,
    Callback = function(Options)
        if ToggleEnabled then
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

local stopFarming = false 

local stopFarming = false -- Flag to stop the autofarm

local Toggle = Menu:CreateToggle({
    Name = "Start Auto Collect Stars ⚠️YOU HAVE TO STAND IN THE MAP THAT YOU CHOSE⚠️",
    CurrentValue = false,
    Callback = function(Value)
        ToggleEnabled = Value 
        getgenv().AutoColStars = Value

        if Value then
            stopFarming = false 
            task.spawn(function()
                AutoCollectStars(selectedMap)
            end)
        else
            stopFarming = true 


            Rayfield:Notify({
                Title = "Auto Collect Stopped",
                Content = "The auto collect feature has been disabled.",
                Duration = 2.5,
                Image = 17091459839,
            })

            print("Auto Collect Stars stopped.")
        end
    end,
})

local Section = Menu:CreateSection("Player", "person-standing")

local Input = Menu:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
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
        "Sakura Egg"
    },
    CurrentOption = "Basic Egg",
    MultipleOptions = false,
    Callback = function(Options)
        selectedEgg = Options[1]  
        Teleport()  
    end,
})
local Section = TP:CreateSection("Map Teleports")

TP:CreateDropdown({
    Name = "Select Map",
    Options = {
        "SPAWN",
        "Autumn Forest",
        "Flower Garden",
        "Snow Forest",
        "Tropical Palms",
        "Mine Shaft",
        "Diamond Mine",
        "Magical Forest",
        "Sakura Forest"
    },
    CurrentOption = "SPAWN",
    MultipleOptions = false,
    Callback = function(Options)
        selectedMap = Options[1]  
        TeleportMap()  
    end,
})

local Pet = Window:CreateTab("Pets", "bone")
local Section = Pet:CreateSection("Auto make golden pets")



-- Credits
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Founder Developer")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Co-Developer")
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
