-- Global Values
getgenv().RevealSkinwalkers = false

-- Locals
local eu = game:GetService("Pllayers").LocalPlayer

-- Functions
local function RevealSkinwalkers()
  while getgenv().RevealSkinwalkers and task.wait(3) do
    for _, skinwalker in pairs(workspace.Runners.Skinwalkers:GetChildren()) do
      if skinwalker.Humanoid.Health > 0 then
        local pos = skinwalker.HumanoidRootPart.CFrame.Position
        game:GetService("ReplicatedStorage").Remotes.PlaceTrap:FireServer(Vector3.new(pos.X, 126.11563110351562, pos.Z))
      end
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
while getgenv().Trap and task.wait(0.3) do
local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position
local args = {
    [1] = Vector3.new(pos.X, 126.11563110351562, pos.Z)
}

game:GetService("ReplicatedStorage").Remotes.PlaceTrap:FireServer(unpack(args))
end

getgenv().ShootSkinwalker = true
local function ShootSkinwalker()
  while getgenv().ShootSkinwalker and task.wait(0.33) do
    for _, skinwalker in pairs(workspace.Runners.Skinwalkers:GetChildren()) do
      if skinwalker.Humanoid.Health > 0 and (skinwalker.HumanoidRootPart.CFrame.Position - workspace["NEW MAP"].Village.Detector).Magnitude <= 15 then
        game:GetService("ReplicatedStorage").Remotes.SniperShot:FireServer(Vector3.new(-86.41163635253906, 140.996826171875, 307.8087158203125), Vector3.new(-81.71827697753906, 128.5720977783203, -76.3155517578125), skinwalker)
      end
    end
  end
end
ShootSkinwalker()

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