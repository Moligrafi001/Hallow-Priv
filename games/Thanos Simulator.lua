-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Thanos%20Simulator.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Thanos Simulator",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
_G.SoulAura = false

-- Funções
local function EquipAll()
	game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("Hallow_Hub", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
	for _, class in pairs(workspace.Spawn.Classes:GetChildren()) do
		if class.Button:FindFirstChild("ClickDetector") then
			fireclickdetector(class.Button.ClickDetector)
		end
	end
	wait(0.9)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("Hallow_Hub")
end
local function SoulAura()
	while _G.SoulAura == true do
		if game.Players.LocalPlayer.Backpack:FindFirstChild("Soul Stone") and not game.Players.LocalPlayer.Character:FindFirstChild("Soul Stone") then
			game.Players.LocalPlayer.Backpack["Soul Stone"].Parent = game.Players.LocalPlayer.Character
			for _, item in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if item:IsA("Tool") and item.Name ~= "Soul Stone" then
					item.Parent = game.Players.LocalPlayer.Backpack
					item.Parent = game.Players.LocalPlayer.Character
				end
			end
		end
		wait(0.01)
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

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Infinity Stones")
local Button = Menu:CreateButton({
   Name = "Get Reality Stone",
   Callback = function()
   		if workspace:FindFirstChild("Reality Stone ") then
       workspace["Reality Stone "].Handle.Position = game.Players.LocalPlayer.Character.Head.Position
       Rayfield:Notify({
		   Title = "Got it! Yay!",
		   Content = "Sucessfully got the Reality Stone!",
		   Duration = 3,
		   Image = 17091459839,
       })
      else
       Rayfield:Notify({
		   Title = "It's not ready!",
		   Content = "The Reality Stone didn't spawned yet.",
		   Duration = 3,
		   Image = 17091459839,
       })
      end
    end,
})
local Button = Menu:CreateButton({
   Name = "Get Time Stone",
   Callback = function()
       if workspace:FindFirstChild("TimeStone") then
       workspace.TimeStone.Handle.Position = game.Players.LocalPlayer.Character.Head.Position
       Rayfield:Notify({
		   Title = "Got it! Yay!",
		   Content = "Sucessfully got the Time Stone!",
		   Duration = 3,
		   Image = 17091459839,
       })
      else
       Rayfield:Notify({
		   Title = "It's not ready!",
		   Content = "The Time Stone didn't spawned yet.",
		   Duration = 3,
		   Image = 17091459839,
       })
      end
    end,
})
local Button = Menu:CreateButton({
   Name = "Get Space Stone",
   Callback = function()
   		if workspace:FindFirstChild("Space stone") then
       workspace["Space stone"].Handle.Position = game.Players.LocalPlayer.Character.Head.Position
       Rayfield:Notify({
		   Title = "Got it! Yay!",
		   Content = "Sucessfully got the Space Stone!",
		   Duration = 3,
		   Image = 17091459839,
       })
      else
       Rayfield:Notify({
		   Title = "It's not ready!",
		   Content = "The Space Stone didn't spawned yet.",
		   Duration = 3,
		   Image = 17091459839,
       })
      end
    end,
})
local Section = Menu:CreateSection("More")
local Toggle =  Menu:CreateToggle({
   Name = "Damage Aura (Needs Soul Stone)",
   CurrentValue = false,
   Callback = function(Value)
   	_G.SoulAura = Value
   	SoulAura()
   end,
})
local Button = Menu:CreateButton({
   Name = "Equip All Items",
   Callback = function()
       EquipAll()
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