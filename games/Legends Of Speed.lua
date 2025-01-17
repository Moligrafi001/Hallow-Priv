-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Legends%20Of%20Speed.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Legends Of Speed",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

local selectedMap = Nenhum
local selectedCrystOvo = Nenhum
local function TPtoMap()
	if selectedMap == "City" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-567.497498, 4.16624975, 406.7341, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		game.Players.LocalPlayer.currentMap.Value = "City"
	elseif selectedMap == "Snow City" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-866.386841, 4.21624994, 2165.70654, -0.499959469, 5.46386332e-08, -0.866048813, -5.43531176e-09, 1, 6.62272939e-08, 0.866048813, 3.78182072e-08, -0.499959469)
		game.Players.LocalPlayer.currentMap.Value = "Snow City"
	elseif selectedMap == "Magma City" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1616.82703, 4.26625776, 4330.65234, -1.60141235e-14, 8.75789965e-08, -1, 9.94003102e-09, 1, 8.75789965e-08, 1, -9.94003102e-09, -1.68846616e-14)
		game.Players.LocalPlayer.currentMap.Value = "Magma City"
	elseif selectedMap == "Legends Highway" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3678.62549, 71.7461929, 5592.35254, -8.45331292e-14, -6.75154652e-08, -1, -4.77619579e-08, 1, -6.75154652e-08, 1, 4.77619579e-08, -8.77577972e-14)
		game.Players.LocalPlayer.currentMap.Value = "Magma City"
	else
		Rayfield:Notify({
	   Title = "No map selected.",
	   Content = "You have to select it before you teleport.",
	   Duration = 2.5,
	   Image = 17091459839,
		})
	end
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

-- Valores
_G.AutoXP = false
_G.FarmS = false
_G.FarmG = false
_G.AutoRebirth = false
_G.AutoHoop = false
_G.AutoOvo = false

-- Funções
local function AutoXP()
		while _G.AutoXP == true do
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "Snow City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "Magma City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "Desert")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "Space")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "Legends Highway")
			wait(0.0001)
		end
end
local function FarmS()
		while _G.FarmS == true do
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Snow City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Desert")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Space")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "Legends Highway")
			wait(0.0001)
		end
end
local function FarmG()
		while _G.FarmG == true do
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Snow City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Magma City")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Desert")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Space")
			game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "Legends Highway")
			wait(0.0001)
		end
end
local function AutoRebirth()
		while _G.AutoRebirth == true do
			game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
			wait(1)
		end
end
local function AutoHoop()
	while _G.AutoHoop == true do
		for _, aro in pairs(workspace.Hoops:GetChildren()) do
			if not aro:FindFirstChild("beingUsed") then
				firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), aro, 0)
				firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart"), aro, 1)
			end
		end
		wait(0.01)
	end
end
local function UnlockTPs()
	for _, part in pairs(workspace.areaCircles:GetChildren()) do
		if part.Name == "areaCircle" then
			part.requiredAmount.Value = 0
		end
	end
		Rayfield:Notify({
	   Title = "Unlocked all the portals.",
	   Content = "Now you can enter in any world or map.",
	   Duration = 4,
	   Image = 17091459839,
		})
end
local function CrystOvo()
	if selectedCrystOvo == "Blue Crystal - 600 Gems" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Blue Crystal")
	elseif selectedCrystOvo == "Red Crystal - 800 Gems" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Red Crystal")
	elseif selectedCrystOvo == "Purple Crystal - 1k Gems" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Purple Crystal")
	elseif selectedCrystOvo == "Yellow Crystal - 1.2k" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Yellow Crystal")
	elseif selectedCrystOvo == "Lightning Crystal - 2.5k" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Lightning Crystal")
	elseif selectedCrystOvo == "Snow Crystal - 4k" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Snow Crystal")
	elseif selectedCrystOvo == "Lava Crystal - 8k" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Lava Crystal")
	elseif selectedCrystOvo == "Inferno Crystal - 8k" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Inferno Crystal")
	elseif selectedCrystOvo == "Electro Legends Crystal - 100k" then
		game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Electro Legends Crystal")
	else
		Rayfield:Notify({
	   Title = "No crystal selected.",
	   Content = "You have to select it before you hatch.",
	   Duration = 2.5,
	   Image = 17091459839,
		})
	end
end
local function AutoOvo()
	while _G.AutoOvo == true do
		CrystOvo()
		wait(0.25)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Farm XP",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoXP = Value
       AutoXP()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Farm Steps",
   CurrentValue = false,
   Callback = function(Value)
       _G.FarmS = Value
       FarmS()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Farm Gems",
   CurrentValue = false,
   Callback = function(Value)
       _G.FarmG = Value
       FarmG()
   end,
})
local Section = Menu:CreateSection("Others")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Hoop",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoHoop = Value
       AutoHoop()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoRebirth = Value
       AutoRebirth()
   end,
})

-- Animal
local AnimalTab = Window:CreateTab("Pets", "paw-print")
local Section = AnimalTab:CreateSection("Hatch Crystal")
local Dropdown = AnimalTab:CreateDropdown({
   Name = "Selected Crystal",
   Options = {"Blue Crystal - 600 Gems", "Red Crystal - 800 Gems", "Purple Crystal - 1k Gems", "Yellow Crystal - 1.2k", "Lightning Crystal - 2.5k", "Snow Crystal - 4k", "Lava Crystal - 8k", "Inferno Crystal - 8k", "Electro Legends Crystal - 100k"},
   CurrentOption = {"No Crystal Selected"},
   MultipleOptions = false,
   Callback = function(Options)
   		selectedCrystOvo = Options[1]
   end,
})
local Toggle =  AnimalTab:CreateToggle({
   Name = "Auto Hatch Crystal",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoOvo = Value
       AutoOvo()
   end,
})
local Button = AnimalTab:CreateButton({
   Name = "Hatch Crystal",
   Callback = function()
       CrystOvo()
    end,
})

-- Teleport
local TPsTab = Window:CreateTab("Teleport", "Shell")
local Section = TPsTab:CreateSection("Teleport to Map")
local Dropdown = TPsTab:CreateDropdown({
   Name = "Selected Map",
   Options = {"City", "Snow City", "Magma City", "Legends Highway"},
   CurrentOption = {"No Map Selected"},
   MultipleOptions = false,
   Callback = function(Options)
   		selectedMap = Options[1]
   end,
})
local Button = TPsTab:CreateButton({
   Name = "Teleport to Map",
   Callback = function()
       TPtoMap()
    end,
})
local Section = TPsTab:CreateSection("More")
local Button = TPsTab:CreateButton({
   Name = "Unlock All Portals",
   Callback = function()
       UnlockTPs()
    end,
})

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
local Section = MoveTab:CreateSection("Walk")
local Input = MoveTab:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	_G.SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	_G.NoClip = Value
   	NoClip()
   end,
})
local Section = MoveTab:CreateSection("Jump")
local Input = MoveTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	_G.SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	_G.InfJump = Value
   	InfJump()
   end,
})

-- Credits.
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Creator")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Co-Dev")
local Label = Credits:CreateLabel("Discord: world_star_hacker", "at-sign")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("https://discord.gg/AESCuek87s")
local Button = Credits:CreateButton({
   Name = "Copy Server Link",
   Callback = function()
       setclipboard("https://discord.gg/AESCuek87s")
       toclipboard("https://discord.gg/AESCuek87s")
    end,
})