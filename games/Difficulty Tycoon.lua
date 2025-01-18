local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Difficulty Tycoon",
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
getgenv().AutoCollect = false
getgenv().AutoBuy = false
getgenv().AutoClick = false
getgenv().AntiLasers = false

-- Funções
local function AutoCollect()
  local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
  local function Interact()
    for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
      if tycoon:IsA("Model") and tycoon.Values.OwnerValue.Value == game.Players.LocalPlayer and character and character.HumanoidRootPart and character.Humanoid and character.Humanoid.Health >= 1 then
        firetouchinterest(character.HumanoidRootPart, tycoon.MainItems.CashCollector.Button, 0)
        firetouchinterest(character.HumanoidRootPart, tycoon.MainItems.CashCollector.Button, 1)
      end
    end
  end
  while getgenv().AutoCollect == true do
    pcall(function()
      Interact()
    end)
    wait(1.5)
  end
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle = Menu:CreateToggle({
   Name = "Auto Collect Money",
   CurrentValue = false,
   Callback = function(Value)
    getgenv().AutoCollect = Value
    AutoCollect()
   end,
})