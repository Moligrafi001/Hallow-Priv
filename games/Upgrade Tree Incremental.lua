-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/upgtreeinc.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Upgrade Tree Incremental",
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

-- Valores
getgenv().AutoUpg = false
getgenv().AutoEngr = false
getgenv().AutoAssemble = false

-- Funções
local function AutoUpg()
  while getgenv().AutoUpg == true do
    for _, button in pairs(workspace.LocalObjects.Buttons:GetChildren()) do
      if getgenv().AutoUpg == true and button.Screen.SurfaceGui.Button.Cost.Text ~= "Maxed" and button.Base.Color ~= Color3.fromRGB(255, 0, 0) then
        fireclickdetector(button.Screen.ClickDetector)
      end
    end
    wait(0.25)
  end
end
local function AutoEngr()
  while getgenv().AutoEngr == true do
    pcall(function()
      game:GetService("ReplicatedStorage").PurchaseEvent:FireServer("EnergyMachine", "Buy1")
    end)
    wait(0.25)
  end
end
local function AutoAssemble()
  while getgenv().AutoAssemble == true do
    pcall(function()
      game:GetService("ReplicatedStorage").PurchaseEvent:FireServer("AssemblyMachine", "Reset")
    end)
    wait(0.25)
  end
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Upgrade")
local Toggle = Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
    getgenv().AutoUpg = Value
    AutoUpg()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Energy Machine",
   CurrentValue = false,
   Callback = function(Value)
    getgenv().AutoEngr = Value
    AutoEngr()
   end,
})
local Section = Menu:CreateSection("Reset")
local Toggle = Menu:CreateToggle({
   Name = "Auto Assemble",
   CurrentValue = false,
   Callback = function(Value)
    getgenv().AutoAssemble = Value
    AutoAssemble()
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