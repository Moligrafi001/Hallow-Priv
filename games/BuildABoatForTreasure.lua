-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Build%20a%20Boat%20for%20the%20Treasure.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Build A Boat For Treasure!",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
getgenv().SetWalkSpeed = false
getgenv().SetJumpPower = false
getgenv().InfJump = false
getgenv().NoClip = false
local function SetWalkSpeed()
	while getgenv().SetWalkSpeed == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
		end
		wait(0.01)
	end
	if getgenv().SetWalkSpeed == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end
local function SetJumpPower()
	while getgenv().SetJumpPower == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower ~= JumpPowerText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = JumpPowerText
		end
		wait(0.01)
		end
	if getgenv().SetJumpPower == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
	end
end
local function InfJump()
	while getgenv().InfJump == true do
		game:GetService("UserInputService").JumpRequest:connect(function()
			if getgenv().InfJump == true then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
		wait(0.1)
	end
end
local function NoClip()
	while getgenv().NoClip == true do
		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if getgenv().NoClip then
					part.CanCollide = false
				else
					part.CanCollide = true
				end
			end
		end
		wait(0.1)
	end
end

-- Locals
local selectedTp = false

-- Values
getgenv().AntiBarriers = false
getgenv().NoWater = false
getgenv().NoSand = false

-- workspace.ChangeTeam:FireServer(game:GetService("Teams").white)

local function TpTeam()
	local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
	if character:FindFirstChild("Humanoid") then
		if character.Humanoid.Health <= 0 then
			Rayfield:Notify({
				Title = "You're dead!",
				Content = "You need to be alive to teleport.",
				Duration = 2.5,
				Image = 17091459839,
			})
		else
			if selectedTp == "White" then
				character.HumanoidRootPart.CFrame = CFrame.new(-49.8767357, -9.70000172, -553.887329, -0.999787033, 1.25884325e-08, -0.0206365604, 1.47957655e-08, 1, -1.06809573e-07, 0.0206365604, -1.07092156e-07, -0.999787033)
			elseif selectedTp == "Red" then
				character.HumanoidRootPart.CFrame = CFrame.new(425.057861, -9.70000172, -64.5107422, 0.0343699642, 1.23541966e-07, 0.999409199, 3.98828561e-08, 1, -1.24986585e-07, -0.999409199, 4.4155076e-08, 0.0343699642)
			elseif selectedTp == "Black" then
				character.HumanoidRootPart.CFrame = CFrame.new(-531.822144, -9.70000267, -69.1551514, -0.00589912944, 1.20717658e-07, -0.999982595, -9.69744374e-09, 1, 1.2077696e-07, 0.999982595, 1.04097539e-08, -0.00589912944)
			elseif selectedTp == "Blue" then
				character.HumanoidRootPart.CFrame = CFrame.new(425.261688, -9.70000172, 300.105286, 0.00153439876, 1.43000376e-08, 0.999998808, 2.10142148e-09, 1, -1.43032786e-08, -0.999998808, 2.12336593e-09, 0.00153439876)
			elseif selectedTp == "Green" then
				character.HumanoidRootPart.CFrame = CFrame.new(-533.034668, -9.70000267, 293.827362, 0.00386504922, -5.97546501e-09, -0.999992549, 2.27750636e-08, 1, -5.8874825e-09, 0.999992549, -2.2752138e-08, 0.00386504922)
			elseif selectedTp == "Magenta" then
				character.HumanoidRootPart.CFrame = CFrame.new(426.041626, -9.70000172, 646.9021, 0.0128429839, 2.46640219e-09, 0.999917507, 5.62189184e-09, 1, -2.53881338e-09, -0.999917507, 5.65403413e-09, 0.0128429839)
			elseif selectedTp == "Yellow" then
				character.HumanoidRootPart.CFrame = CFrame.new(-532.347107, -9.70000267, 640.261658, -0.0351400562, -9.47882128e-09, -0.999382377, -7.10814092e-08, 1, -6.98533098e-09, 0.999382377, 7.07920407e-08, -0.0351400562)
			else
				Rayfield:Notify({
						Title = "No team selected.",
						Content = "You have to select it before you teleport.",
						Duration = 2.5,
						Image = 17091459839,
					})
			end
		end
	end
end
local function AntiBarriers()
	print("Pressed!")
end
-- workspace.BoatStages.OtherStages.WashingMachineStage:GetChildren()[25].Part1
local function NoWater()
	while getgenv().NoWater == true do
		if workspace.Water.CanTouch == true then
			workspace.Water.CanTouch = false
		end
		for _, stage in pairs(workspace.BoatStages.NormalStages:GetChildren()) do
			if stage:FindFirstChild("Water") then
				if stage.Water.CanTouch == true then
					stage.Water.CanTouch = false
				end
			end
		end
		for _, stage in pairs(workspace.BoatStages.OtherStages:GetChildren()) do
			if stage:FindFirstChild("Water") and stage.Water:IsA("Part") then
				if stage.Water.CanTouch == true then
					stage.Water.CanTouch = false
				end
			end
			if stage.Name == "WashingMachineStage" then
				if stage:FindFirstChild("Water") then
					for _, water in pairs(stage.Water:GetChildren()) do
						if water.CanTouch == true then
							water.CanTouch = false
						end
					end
				end
			end
		end
		wait(0.01)
	end
	if getgenv().NoWater == false then
		if workspace.Water.CanTouch == false then
			workspace.Water.CanTouch = true
		end
		for _, stage in pairs(workspace.BoatStages.NormalStages:GetChildren()) do
			if stage:FindFirstChild("Water") then
				if stage.Water.CanTouch == false then
					stage.Water.CanTouch = true
				end
			end
		end
		for _, stage in pairs(workspace.BoatStages.OtherStages:GetChildren()) do
			if stage:FindFirstChild("Water") and stage.Water:IsA("Part") then
				if stage.Water.CanTouch == false then
					stage.Water.CanTouch = true
				end
			end
			if stage.Name == "WashingMachineStage" then
				if stage:FindFirstChild("Water") then
					for _, water in pairs(stage.Water:GetChildren()) do
						if water.CanTouch == false then
							water.CanTouch = true
						end
					end
				end
			end
		end
	end
end
local function NoSand()
	while getgenv().NoSand == true do
		if workspace.Sand.CanTouch == true then
			workspace.Sand.CanTouch = false
		end
		for _, stage in pairs(workspace.BoatStages.NormalStages:GetChildren()) do
			if stage:FindFirstChild("Sand") then
				if stage.Sand.CanTouch == true then
					stage.Sand.CanTouch = false
				end
			end
		end
		for _, stage in pairs(workspace.BoatStages.OtherStages:GetChildren()) do
			if stage:FindFirstChild("Sand") then
				if stage.Sand.CanTouch == true then
					stage.Sand.CanTouch = false
				end
			end
		end
		wait(0.01)
	end
	if getgenv().NoSand == false then
		if workspace.Sand.CanTouch == false then
			workspace.Sand.CanTouch = true
		end
		for _, stage in pairs(workspace.BoatStages.NormalStages:GetChildren()) do
			if stage:FindFirstChild("Sand") then
				if stage.Sand.CanTouch == false then
					stage.Sand.CanTouch = true
				end
			end
		end
		for _, stage in pairs(workspace.BoatStages.OtherStages:GetChildren()) do
			if stage:FindFirstChild("Sand") then
				if stage.Sand.CanTouch == false then
					stage.Sand.CanTouch = true
				end
			end
		end
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Helpful")
local Toggle = Menu:CreateToggle({
   Name = "No Water Damage",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().NoWater = Value
   	NoWater()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "No Sand Damage",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().NoSand = Value
   	NoSand()
   end,
})
local Section = Menu:CreateSection("Misc")
local Toggle = Menu:CreateToggle({
   Name = "Anti Barriers",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiBarriers = Value
   	AntiBarriers()
   end,
})

-- Teleport
local TPsTab = Window:CreateTab("Teleport", "Shell")
local Section = TPsTab:CreateSection("Teleport to Team")
local Dropdown = TPsTab:CreateDropdown({
   Name = "Selected Team",
   Options = {"White", "Red", "Black", "Blue", "Green", "Magenta", "Yellow"},
   CurrentOption = {"No Map Selected"},
   MultipleOptions = false,
   Callback = function(Options)
   		selectedTp = Options[1]
   end,
})
local Button = TPsTab:CreateButton({
   Name = "Teleport to Team",
   Callback = function()
       TpTeam()
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
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
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
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})

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