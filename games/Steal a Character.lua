-- Global Values
getgenv().AutoCollect = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Studio = nil
}

-- Loading
for _, studio in pairs(workspace.Studios:GetChildren()) do
  if studio:GetAttribute("Owner") == eu.UserId then
    Settings.Studio = studio
    break
  end
end

-- Functions
local function AutoCollect()
  while getgenv().AutoCollect and task.wait(1) do
    
  end
end
local function AutoLock()
  while getgenv().AutoLock and task.wait(1) do
    if not Settings.Studio:GetAttribute("Locked") and eu.leaderstats.Worth.Value >= 30000 then
      firetouchinterest(eu.Character.HumanoidRootPart, Settings.Studio.LockOneMin.Hitbox, 0)
      firetouchinterest(eu.Character.HumanoidRootPart, Settings.Studio.LockOneMin.Hitbox, 1)
    end
  end
end

for _, studio in pairs(workspace.Studios:GetChildren()) do
if studio:GetAttribute("Owner") == game.Players.LocalPlayer.UserId then
print(studio.Name)
if studio:GetAttribute("Locked") == false then
end
end
end
game:GetService("Players").LocalPlayer.leaderstats.Worth.Value
workspace.Studios:GetChildren()[9].LockOneMin.Hitbox.TouchInterest
workspace.Studios:GetChildren()[9].Platforms:GetChildren()[3].Collect.TouchInterest
workspace.Studios:GetChildren()[9].Platforms:GetChildren()[3].Noob
workspace.Studios.Studio.Barrier.Invisibleace.Studios
