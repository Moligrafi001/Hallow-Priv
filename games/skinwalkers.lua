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

local function ShootSkinwalker()
  while getgenv().ShootSkinwalker and task.wait(0.33) do
    for _, skinwalker in pairs(workspace.Runners.Skinwalkers:GetChildren()) do
      if skinwalker.Humanoid.Health > 0 and (skinwalker.HumanoidRootPart.CFrame.Position - workspace["NEW MAP"].Village.Detector).Magnitude <= 15 then
        game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.41163635253906, 140.996826171875, 307.8087158203125), Vector3.new(-81.71827697753906, 128.5720977783203, -76.3155517578125), skinwalker)
      end
    end
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

-- Menu
local Menu = Window:CreateTab("Menu", "home")
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
  Name = "Reveal Skinwalkers",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().RevealSkinwalkers = Value
    RevealSkinwalkers()
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