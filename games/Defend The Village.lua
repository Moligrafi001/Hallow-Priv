getgenv().AutoUpgrade = false

local function KillAll()
local function AutoKill()
  while getgenv().AutoKill and task.wait(1) do
    if not workspace.Things.Zombies:GetAttribute("Connected") then
      workspace.Things.Zombies:SetAttribute("Connected", true)
      workspace.Things.Zombies.ChildAdded:Connect(function(instance)
        if getgenv().AutoKill then
          repeat
            game:GetService("ReplicatedStorage").Networking.Remotes.Weapons.GunFired:FireServer("M1911", instance.HumanoidRootPart.CFrame * CFrame.Angles(-0.04435689374804497, 0.4749751687049866, 0.020295660942792892), {{ id = tonumber(instance.name) }})
            task.wait(0.05)
          until not instance
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