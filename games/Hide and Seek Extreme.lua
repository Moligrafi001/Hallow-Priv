-- workspace.GameObjects:GetChildren()[5]:GetChildren()[5]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Hide and Seek Extreme",
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
	  pcall(function()
  		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
  			if part:IsA("BasePart") then
  				if getgenv().NoClip then
  					part.CanCollide = false
  				else
  					part.CanCollide = true
  				end
  			end
  		end
		end)
		wait(0.1)
	end
end

-- Valores
getgenv().AutoCredit = false

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function GetCredit()
  pcall(function()
    if eu.PlayerData.InGame.Value == true then
      for _, credit in pairs(workspace.GameObjects:GetChildren()) do
        if credit:FindFirstChild("TouchInterest") and credit.Name == "Credit" and eu.Character and eu.Character.HumanoidRootPart then
          firetouchinterest(eu.Character.HumanoidRootPart, credit, 0)
          firetouchinterest(eu.Character.HumanoidRootPart, credit, 1)
          tick.wait(0.05)
        end
      end
    end
  end)
end
local function AutoCredit()
  while getgenv().AutoCredit do
    pcall(function()
      GetCredit()
    end)
    wait(1.5)
  end
end
local function CaptureAll()
  for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player ~= eu then
      if eu.PlayerData.It.Value == true and eu.PlayerData.InGame.Value == true then
        if player.PlayerData.InGame.Value == true and player.PlayerData.It.Value == false then
          eu.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
      elseif eu.PlayerData.InGame.Value == false then
        Rayfield:Notify({
          Title = "Hey, wait!",
          Content = "You are not alive.",
          Duration = 2.6,
          Image = 17091459839,
        })
      elseif eu.PlayerData.It.Value == false then
        Rayfield:Notify({
          Title = "Hey, wait!",
          Content = "You are not the It.",
          Duration = 2.6,
          Image = 17091459839,
        })
      end
    end
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Credits",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCredit = Value
   	AutoCredit()
   end,
})
Button =  Menu:CreateButton({
   Name = "Collect Credits",
   Callback = function(Value)
   	GetCredit()
   end,
})
Button =  Menu:CreateButton({
   Name = "Capture Everyone",
   Callback = function(Value)
   	CaptureAll()
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