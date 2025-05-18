local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
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
getgenv().ExterminateNightwalkers = false
getgenv().Fullbright = false

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function AuraDetector()
end
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
      workspace.GameObjects:SetAttribute("Connected", true)
      workspace.GameObjects.ChildAdded:Connect(function(instance)
        if getgenv().CollectMoneyBags and instance.Name == "MoneyBag" then
          fireproximityprompt(instance.ProximityPrompt)
        end
      end)
    end
  end
end
local function ProtectDetector()
  local function GetNearbySkinwalkers()
    local Detected = {}
    for _, part in pairs(workspace:GetPartBoundsInBox(workspace["NEW MAP"].Village.Detector.CFrame, Vector3.new(45, 10, 45), nil)) do
      local model, humanoid, root = part:FindFirstAncestorWhichIsA("Model"), model:FindFirstChild("Humanoid"), model:FindFirstChild("HumanoidRootPart")
      if model and model:IsAncestorOf(workspace.Runners.Skinwalkers) and humanoid and humanoid.Health > 0 and root then
        Detected[model] = root
      end
    end
    return Detected
  end
  while getgenv().ProtectDetector and task.wait(0.33) do
    pcall(function()
      for _, skinwalker in pairs(GetNearbySkinwalkers()) do
        game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.41163635253906, 140.996826171875, 307.8087158203125), Vector3.new(-81.71827697753906, 128.5720977783203, -76.3155517578125), root)
      end
    end)
  end
end
local function KillAll(who)
  local function Shoot(instance)
    game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.41163635253906, 140.996826171875, 307.8087158203125), Vector3.new(-81.71827697753906, 128.5720977783203, -76.3155517578125), instance)
  end
  if who == "skinwalkers" then
    for _, skinwalker in pairs(workspace.Runners.Skinwalkers:GetChildren()) do
      if skinwalker.Humanoid.Health > 0 then
        Shoot(skinwalker.HumanoidRootPart)
      end
    end
  elseif who == "nightwalkers" then
    for _, nightwalker in pairs(workspace.Nightwalkers:GetChildren()) do
      if nightwalker.Humanoid.Health > 0 then
      end
    end
  end
end
local function ExterminateSkinwalkers()
  while getgenv().ExterminateSkinwalkers and task.wait(3) do
    pcall(function()
      KillAll("skinwalkers")
    end)
  end
end
local function ExterminateNightwalkers()
  while getgenv().ExterminateNightwalkers and task.wait(3) do
    pcall(function()
      KillAll("nightwalkers")
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
local MovementTexts = {
  WalkSpeedText = 16,
  JumpPowerText = 50
}
getgenv().SetWalkSpeed = false
getgenv().SetJumpPower = false
getgenv().InfJump = false
getgenv().NoClip = false
local function SetWalkSpeed()
  while getgenv().SetWalkSpeed and task.wait(1) do
    pcall(function()
      local function CheckSet()
        if eu.Character.Humanoid.WalkSpeedText ~= MovementTexts.WalkSpeedText then
          eu.Character.Humanoid.WalkSpeedText = MovementTexts.WalkSpeedText
        end
      end
      CheckSet()
      if not eu.Character.Humanoid:GetAttribute("SpeedConnected") then
        eu.Character.Humanoid:SetAttribute("SpeedConnected", true)
        eu.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
          if getgenv().SetWalkSpeed then CheckSet() end
        end)
      end
		end)
  end
end
local function SetJumpPower()
  while getgenv().SetJumpPower and task.wait(1) do
    pcall(function()
      local function CheckSet()
        if eu.Character.Humanoid.JumpPower ~= MovementTexts.JumpPowerText then
          eu.Character.Humanoid.JumpPowerText = MovementTexts.JumpPowerText
        end
      end
      CheckSet()
      if not eu.Character.Humanoid:GetAttribute("JumpConnected") then
        eu.Character.Humanoid:SetAttribute("JumpConnected", true)
        eu.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
          if getgenv().SetJumpPower then CheckSet() end
        end)
      end
		end)
  end
end
local function InfJump()
  while getgenv().InfJump and task.wait(1) do
    if not game:GetService("UserInputService"):GetAttribute("JumpConnected") then
      game:GetService("UserInputService"):SetAttribute("JumpConnected", true)
      game:GetService("UserInputService").JumpRequest:Connect(function()
        if getgenv().InfJump then
         eu.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
        end
      end)
    end
	end
end
local function NoClip()
	while getgenv().NoClip and wait(0.1) do
	  pcall(function()
  		for _, part in pairs(eu.Character:GetDescendants()) do
  			if part:IsA("BasePart") then
  				if getgenv().NoClip then
  					part.CanCollide = false
  				else
  					part.CanCollide = true
  				end
  			end
  		end
		end)
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
   	MovementTexts.WalkSpeedText = tonumber(Text)
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
   	MovementTexts.JumpPowerText = tonumber(Text)
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