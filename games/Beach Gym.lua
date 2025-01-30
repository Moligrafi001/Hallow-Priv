local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | BaBGaPBW",
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
	  pcall(function()
  		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
  			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
  		end
		end)
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
getgenv().AutoTrain = false
getgenv().AutoBuy = false
getgenv().Win1 = false
getgenv().Win2 = false

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function AutoTrain()
  while getgenv().AutoTrain do
    game:GetService("ReplicatedStorage").Remotes.Trick:FireServer("Train")
    wait(0.1)
  end
end
local function AutoBuy()
  while getgenv().AutoBuy do
    for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
      if tycoon:GetAttribute("Owner") == eu.Name then
        for _, button in pairs(tycoon.Buttons:GetChildren()) do
          if button.Touch.Transparency == 0 and button.Touch.Color == Color3.fromRGB(34, 159, 61) and not button.Touch:FindFirstChild("Attachment") then
            firetouchinterest(eu.Character.HumanoidRootPart, button.Touch, 0)
            firetouchinterest(eu.Character.HumanoidRootPart, button.Touch, 1)
            break
          end
        end
      end
    end
    wait(1)
  end
end
local function Win1()
	local Busy = false
	while getgenv().Win1 == true do
		if Busy == false then
			game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("EasyPosition", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
		end
		if workspace.Obbystuff["3MinCD"].SurfaceGui.Enabled == false then
			Busy = true
			wait(0.25)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["3Min"], 0)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["3Min"], 1)
			wait(0.25)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("EasyPosition")
			Busy = false
		end
		wait(0.50)
	end
end
local function Win2()
	local Busy = false
	while getgenv().Win2 == true do
		if Busy == false then
			game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("MediumPosition", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
		end
		if workspace.Obbystuff["5MinCD"].SurfaceGui.Enabled == false then
			Busy = true
			wait(0.25)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["5Min"], 0)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Obbystuff["5Min"], 1)
			wait(0.25)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("MediumPosition")
			Busy = false
		end
		wait(0.50)
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Train",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoTrain = Value
   	AutoTrain()
   end,
})
Section = Menu:CreateSection("Upgrade")
Toggle =  Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoBuy = Value
   	AutoBuy()
   end,
})
Section = Menu:CreateSection("Auto Obby")
Toggle =  Menu:CreateToggle({
   Name = "3 Min Obby",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Win1 = Value
   	Win1()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "5 Min Obby",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Win2 = Value
   	Win2()
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