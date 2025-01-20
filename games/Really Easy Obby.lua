local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Really Easy Obby! 🌈",
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

-- Locais
local selecionado = "101"

-- Valores
getgenv().AntiKill = false
getgenv().TrollInv = false

-- Funções
local function AntiKill()
  while getgenv().AntiKill == true do
    for _, v in pairs(workspace:GetChildren()) do
      if v:FindFirstChild("TouchInterest") and v.CanTouch == true and v.Name == "Player Refresher" then
        v.CanTouch = false
      end
    end
    wait(1)
  end
  if getgenv().AntiKill == false then
    for _, v in pairs(workspace:GetChildren()) do
      if v:FindFirstChild("TouchInterest") and v.CanTouch == false and v.Name == "Player Refresher" then
        v.CanTouch = true
      end
    end
  end
end
local function TpCheck()
  pcall(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Checkpoints[selecionado].CFrame
  end)
end
local function TrollInv()
  while getgenv().TrollInv == true do
    pcall(function()
      for _, part in pairs(workspace:GetChildren()) do
        if part:IsA("Part") and part:FindFirstChild("TouchInterest") and part.Name == "Part" and part.Transparency == 0 then
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 0)
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 1)
        end
      end
      for _, part in pairs(workspace.Stairs:GetChildren()) do
        if part:IsA("Part") and part:FindFirstChild("TouchInterest") and part.Name == "Part" and part.Transparency == 0 then
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 0)
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, part, 1)
        end
      end
    end)
    wait(1)
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Toggle =  Menu:CreateToggle({
   Name = "Anti Lasers",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiKill = Value
   	AntiKill()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Troll Stairs",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().TrollInv = Value
   	TrollInv()
   end,
})
Section = Menu:CreateSection("Teleport")
Input = Menu:CreateInput({
   Name = "Checkpoint to Teleport",
   CurrentValue = "",
   PlaceholderText = "Type number from 1 to 101",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	selecionado = "" .. Text .. ""
   end,
})
Button = Menu:CreateButton({
  Name = "Teleport to checkpoint",
  Callback = function()
    TpCheck()
  end,
})

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
Section = MoveTab:CreateSection("Walk")
Input = MoveTab:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
Section = MoveTab:CreateSection("Jump")
Input = MoveTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})