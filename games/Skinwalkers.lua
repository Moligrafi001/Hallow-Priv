local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Skinwalkers [ HORROR ]",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().RevealSkinwalkers = false
getgenv().ProtectDetector = false
getgenv().ShootSkinwalker = false
getgenv().CiviliansESP = false
getgenv().ExterminateSkinwalkers = false
getgenv().Fullbright = false

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function RevealSkinwalkers()
  while getgenv().RevealSkinwalkers and task.wait(3) do
    pcall(function()
      for _, skinwalker in pairs(workspace.Runners.Skinwalkers:GetChildren()) do
        if not skinwalker.Head:FindFirstChild("SkinwalkerNotifier") and skinwalker.Humanoid.Health > 0 then
          local pos = skinwalker.HumanoidRootPart.CFrame.Position
          game:GetService("ReplicatedStorage").Remotes.PlaceTrap:FireServer(Vector3.new(pos.X, 126.11563110351562, pos.Z + 3))
        end
      end
    end)
  end
end
local function CollectMoneyBags()
  if getgenv().CollectMoneyBags then
    for _, pp in pairs(workspace.GameObjects:GetDescendants()) do
      if pp:IsA("ProximityPrompt") then 
        fireproximityprompt(pp) 
      end
    end
    if not workspace.GameObjects:GetAttribute("Connected") then
      workspace.GameObjects.ChildAdded:Connect(function(instance)
        if getgenv().CollectMoneyBags and instance.Name == "MoneyBag" then
          fireproximityprompt(instance.ProximityPrompt)
        end
      end)
      workspace.GameObjects:SetAttribute("Connected", true)
    end
  end
end
local function ProtectDetector()
  while getgenv().ProtectDetector and task.wait(0.33) do
    pcall(function()
      for _, skinwalker in pairs(workspace.Runners.Skinwalkers:GetChildren()) do
        if skinwalker.Humanoid.Health > 0 and (skinwalker.HumanoidRootPart.CFrame.Position - workspace["NEW MAP"].Village.Detector.CFrame.Position).Magnitude <= 45 then
          game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.41163635253906, 140.996826171875, 307.8087158203125), Vector3.new(-81.71827697753906, 128.5720977783203, -76.3155517578125), skinwalker.HumanoidRootPart)
        end
      end
    end)
  end
end
local function KillAll(who)
  if who == "skinwalkers" then
    for _, skinwalker in pairs(workspace.Runners/Skinwalkers:GetChildren()) do
      if skinwalker.Humanoid.Health > 0 then
        game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.41163635253906, 140.996826171875, 307.8087158203125), Vector3.new(-81.71827697753906, 128.5720977783203, -76.3155517578125), skinwalker.HumanoidRootPart)
      end
    end
  elseif who == "nightwalkers" then
    
  end
end
local function ExterminateSkinwalkers()
  while getgenv().ExterminateSkinwalkers and task.wait(3) do
    pcall(function()
      KillAll("skinwalkers")
    end)
  end
end
local function CiviliansESP()
  while getgenv().CiviliansESP and task.wait(0.9) do
    pcall(function()
      for _, skinwalker in pairs(workspace.Runners.Skinwalkers:GetChildren()) do
        if not skinwalker:FindFirstChild("Luz") then
          local highlight = Instance.new("Highlight")
          highlight.FillTransparency = 0.6
          highlight.Adornee, highlight.Parent = skinwalker, skinwalker
          highlight.Name = "Luz"
          highlight.FillColor, highlight.OutlineColor = Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 0, 0)
        end
      end
      for _, civil in pairs(workspace.Runners.Civilians:GetChildren()) do
        if not civil:FindFirstChild("Luz") then
          local highlight = Instance.new("Highlight")
          highlight.FillTransparency = 0.6
          highlight.Adornee, highlight.Parent = civil, civil
          highlight.Name = "Luz"
          highlight.FillColor, highlight.OutlineColor = Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 255, 0)
        end
      end
    end)
  end
end
local function Fullbright()
    while getgenv().Fullbright and wait(0.01) do
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
    end
    game:GetService("Lighting").Brightness = 1
    game:GetService("Lighting").ClockTime = 14
    game:GetService("Lighting").FogEnd = 10000000
    game:GetService("Lighting").GlobalShadows = true
    game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(200, 200, 200)
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Exterminate")
Toggle = Menu:CreateToggle({
  Name = "Auto Kill Skinwalkers",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().ExterminateSkinwalkers= Value
    ExterminateSkinwalkers()
  end
})
Toggle = Menu:CreateButton({
  Name = "Kill All Skinwalkers",
  Callback = function(Value)
    KillAll("skinwalkers")
  end
})
Toggle = Menu:CreateToggle({
  Name = "Protect Village",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().ProtectDetector = Value
    ProtectDetector()
  end
})
Section = Menu:CreateSection("Helpful")
Toggle = Menu:CreateToggle({
  Name = "Reveal Skinwalkers",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().RevealSkinwalkers = Value
    RevealSkinwalkers()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Collect Money Bags",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().CollectMoneyBags = Value
    CollectMoneyBags()
  end
})

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
Toggle = VisualTab:CreateToggle({
  Name = "Fullbright",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().Fullbright = Value
    Fullbright()
  end
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