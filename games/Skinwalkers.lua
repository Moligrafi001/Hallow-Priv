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
getgenv().CollectMoneyBags = false
getgenv().ProtectDetector = false
getgenv().ShootSkinwalker = false
getgenv().CiviliansESP = false
getgenv().ExterminateSkinwalkers = false
getgenv().ExterminateNightwalkers = false
getgenv().Fullbright = false
getgenv().KillAura = false
getgenv().AutoHeal = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Distance = 30,
  Amount = 999,
  Heal = {
    self = true,
    others = true
  }
}

-- Trash Functions
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
        Shoot(nightwalker.Head)
      end
    end
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
    local parts = workspace:GetPartBoundsInBox(workspace["NEW MAP"].Village.Detector.CFrame, Vector3.new(90, 20, 90), nil)
    for _, part in pairs(parts) do
      local model = part:FindFirstAncestorWhichIsA("Model")
      if model and model:IsDescendantOf(workspace.Runners.Skinwalkers) then
        local humanoid = model:FindFirstChild("Humanoid")
        local root = model:FindFirstChild("HumanoidRootPart")
        if humanoid and humanoid.Health > 0 and root then
          Detected[model] = root
        end
      end
    end
    return Detected
  end
  while getgenv().ProtectDetector and task.wait(0.33) do
    pcall(function()
      for _, root in pairs(GetNearbySkinwalkers()) do
        game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.4116, 140.9968, 307.8087), Vector3.new(-81.7182, 128.5721, -76.3155), root)
      end
    end)
  end
end
local function KillAura()
  local function GetNearby()
    local Detected = {}
    for _, part in pairs(workspace:GetPartBoundsInBox(eu.Character.HumanoidRootPart.CFrame, Vector3.new(Settings.Distance, 20, Settings.Distance), nil)) do
      local model = part:FindFirstAncestorWhichIsA("Model")
      if model and model:IsDescendantOf(workspace.Runners.Skinwalkers) or model:IsDescendantOf(workspace.Nightwalkers) then
        local humanoid = model:FindFirstChild("Humanoid")
        local root = model:FindFirstChild("HumanoidRootPart")
        if humanoid and humanoid.Health > 0 then
          if model:IsDescendantOf(workspace.Runners.Skinwalkers) then
            Detected[model] = root
          elseif model:IsDescendantOf(workspace.Nightwalkers) then
            Detected[model] = model:FindFirstChild("Head")
          end
        end
      end
    end
    return Detected
  end
  while getgenv().KillAura and task.wait(0.2) do
    pcall(function()
      for _, root in pairs(GetNearby()) do
        game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.4116, 140.9968, 307.8087), Vector3.new(-81.7182, 128.5721, -76.3155), root)
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
local function AutoHeal()
  while getgenv().AutoHeal and task.wait(1) do
    pcall(function()
      if eu.Character:FindFirstChild("Bandage") or eu.Backpack:FindFirstChild("Bandage") then
        if Settings.Heal.self and eu.Humanoid.Health < eu.Humanoid.MaxHealth then
          game:GetService("ReplicatedStorage").Remotes.Heal:FireServer(eu.Character)
        end
        if Settings.Heal.others then
          for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if p.Character.Humanoid.Health < MaxHealth then
              game:GetService("ReplicatedStorage").Remotes.Heal:FireServer(p.Character)
            end
          end
        end
      end
    end)
  end
end
-- Skinwalkers Functions
local function ExterminateSkinwalkers()
  while getgenv().ExterminateSkinwalkers and task.wait(3) do
    pcall(function()
      KillAll("skinwalkers")
    end)
  end
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
-- Nightwalkers Functions
local function ExterminateNightwalkers()
  while getgenv().ExterminateNightwalkers and task.wait(3) do
    pcall(function()
      KillAll("nightwalkers")
    end)
  end
end
local function RevealNightwalkers()
  while getgenv().RevealNightwalkers and task.wait(3) do
    pcall(function()
      for _, skinwalker in pairs(workspace.Nightwalkers:GetChildren()) do
        if not skinwalker.Head:FindFirstChild("SkinwalkerNotifier") and skinwalker.Humanoid.Health > 0 then
          local pos = skinwalker.WorldPivot.Position
          game:GetService("ReplicatedStorage").Remotes.PlaceTrap:FireServer(Vector3.new(pos.X, 126.11563110351562, pos.Z + 3))
        end
      end
    end)
  end
end
-- Maintenance Functions
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

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Exterminate")
Toggle = Menu:CreateToggle({
  Name = "Protect Village",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().ProtectDetector = Value
    ProtectDetector()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Kill Aura",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().KillAura = Value
    KillAura()
  end
})
Input = Menu:CreateInput({
   Name = "Aura Distance",
   CurrentValue = "15",
   PlaceholderText = "Numbers only, ex.: 15",
   Callback = function(Text)
     Settings.Distance = tonumber(Text) * 2
   end,
})
Section = Menu:CreateSection("Helpful")
Toggle = Menu:CreateToggle({
  Name = "Auto Collect Money Bags",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().CollectMoneyBags = Value
    CollectMoneyBags()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Heal [ Need Bandage ]",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoHeal = Value
    AutoHeal()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Fullbright",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().Fullbright = Value
    Fullbright()
  end
})

-- Blatant
local Blatant = Window:CreateTab("Blatant", "swords")
Section = Blatant:CreateSection("Skinwalkers")
Toggle = Blatant:CreateToggle({
  Name = "Auto Kill Skinwalkers",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().ExterminateSkinwalkers = Value
    ExterminateSkinwalkers()
  end
})
Button = Blatant:CreateButton({
  Name = "Kill All Skinwalkers",
  Callback = function(Value)
    KillAll("skinwalkers")
  end
})
Toggle = Blatant:CreateToggle({
  Name = "Reveal Skinwalkers [ FE ]",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().RevealSkinwalkers = Value
    RevealSkinwalkers()
  end
})
Section = Blatant:CreateSection("Nightwalkers")
Toggle = Blatant:CreateToggle({
  Name = "Auto Kill Nightwalkers",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().ExterminateNightwalkers = Value
    ExterminateNightwalkers()
  end
})
Button = Blatant:CreateButton({
  Name = "Kill All Nightwalkers",
  Callback = function(Value)
    KillAll("nightwalkers")
  end
})
Toggle = Blatant:CreateToggle({
  Name = "Reveal Nightwalkers [ FE ]",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().RevealNightwalkers = Value
    RevealNightwalkers()
  end
})

-- Get Items
local GetItems = Window:CreateTab("Get Items", "gift")
Section = GetItems:CreateSection("Skinwalkers")
Label = GetItems:CreateLabel("CAN BE USED ONLY ONCE", "triangle-alert")
Input = GetItems:CreateInput({
  Name = "Amount to Get",
  CurrentValue = "999",
  PlaceholderText = "1 - 999 ( Only Numbers )",
  RemoveTextAfterFocusLost = false,
  Callback = function(Text)
    Settings.Amount = tonumber(Text)
  end,
})
Button = GetItems:CreateButton({
  Name = "Get Cola",
  Callback = function()
    game:GetService("ReplicatedStorage").Assets.Tools.Cola.Amount.Value = Settings.Amount
    game:GetService("ReplicatedStorage").Assets.Tools.Cola.Parent = eu.Backpack
  end,
})
Button = GetItems:CreateButton({
  Name = "Get Gatling Gun",
  Callback = function()
    game:GetService("ReplicatedStorage").Assets.Tools.Gatling.Parent = eu.Backpack
  end,
})
Button = GetItems:CreateButton({
  Name = "Get Snappers",
  Callback = function()
    game:GetService("ReplicatedStorage").Assets.Tools.Snapper.Amount.Value = Settings.Amount
    game:GetService("ReplicatedStorage").Assets.Tools.Snapper.Parent = eu.Backpack
  end,
})
Button = GetItems:CreateButton({
  Name = "Get Turrets",
  Callback = function()
    game:GetService("ReplicatedStorage").Assets.Tools.Turret.Amount.Value = Settings.Amount
    game:GetService("ReplicatedStorage").Assets.Tools.Turret.Parent = eu.Backpack
  end,
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
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	MovementTexts.WalkSpeedText = tonumber(Text)
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
Section = MoveTab:CreateSection("Jump")
Input = MoveTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	MovementTexts.JumpPowerText = tonumber(Text)
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})