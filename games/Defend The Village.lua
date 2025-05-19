local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Defend The Village",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoUpgrade = false
getgenv().AutoKill = false
getgenv().AutoCollect = false

-- Functions
local function KillAll()
  for _, zombie in pairs(workspace.Things.Zombies:GetChildren()) do
    game:GetService("ReplicatedStorage").Networking.Remotes.Weapons.GunFired:FireServer("M1911", zombie.HumanoidRootPart.CFrame * CFrame.Angles(-0.04435689374804497, 0.4749751687049866, 0.020295660942792892), {{ id = tonumber(zombie.name) }})
  end
end
local function AutoKill()
  while getgenv().AutoKill and task.wait(1) do
    if not workspace.Things.Zombies:GetAttribute("Connected") then
      workspace.Things.Zombies:SetAttribute("Connected", true)
      workspace.Things.Zombies.ChildAdded:Connect(function(instance)
        if getgenv().AutoKill then
          repeat
            game:GetService("ReplicatedStorage").Networking.Remotes.Weapons.GunFired:FireServer("M1911", instance.HumanoidRootPart.CFrame * CFrame.Angles(-0.04435689374804497, 0.4749751687049866, 0.020295660942792892), {{ id = tonumber(instance.name) }})
            task.wait(0.05)
          until instance.Humanoid.Health <= 0
        end
      end)
    end
  end
end
local function CollectDrops()
  for i = 1, 20 do
    game:GetService("ReplicatedStorage").Networking.Remotes.Drops.CollectDrop:FireServer(i)
  end
end
local function AutoCollect()
  while getgenv().AutoCollect and task.wait(5) do
    CollectDrops()
  end
end
local function UpgradeGates()
  for i = 1, 9 do
    game:GetService("ReplicatedStorage").Networking.Remotes.Game.UpgradeGate:FireServer(i)
  end
end
local function AutoUpgrade()
  while getgenv().AutoUpgrade and task.wait(5) do
    UpgradeGates()
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Exterminate")
Toggle = Menu:CreateToggle({
  Name = "Auto Kill Zombies",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoKill = Value
    AutoKill()
  end
})
Button = Menu:CreateButton({
  Name = "Kill Zombies",
  Callback = function(Value)
    KillAll()
  end
})
Section = Menu:CreateSection("Upgrade")
Toggle = Menu:CreateToggle({
  Name = "Auto Upgrade Gates",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoUpgrade = Value
    AutoUpgrade()
  end
})
Button = Menu:CreateButton({
  Name = "Upgrade Gates",
  Callback = function(Value)
    UpgradeGates()
  end
})
Section = Menu:CreateSection("Upgrade")
Toggle = Menu:CreateToggle({
  Name = "Auto Collect Drops",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoCollect = Value
    AutoCollect()
  end
})
Button = Menu:CreateButton({
  Name = "Collect Drops",
  Callback = function(Value)
    CollectDrops()
  end
})