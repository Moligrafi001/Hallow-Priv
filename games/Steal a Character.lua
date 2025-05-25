local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Steal a Character",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoCollect = false
getgenv().AutoLock = false

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
    for _, platform in pairs(Settings.Studio.Platforms:GetChildren()) do
      if platform:FindFirstChildOfClass("Model") then
        firetouchinterest(eu.Character.HumanoidRootPart, platform.Collect, 0)
        firetouchinterest(eu.Character.HumanoidRootPart, platform.Collect, 1)
      end
    end
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

--[[
game:GetService("Players").LocalPlayer.leaderstats.Worth.Value
workspace.Studios:GetChildren()[9].LockOneMin.Hitbox.TouchInterest
workspace.Studios:GetChildren()[9].Platforms:GetChildren()[3].Collect.TouchInterest
workspace.Studios:GetChildren()[9].Platforms:GetChildren()[3].Noob
workspace.Studios.Studio.Barrier.Invisibleace.Studios
--]]

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle = Menu:CreateToggle({
  Name = "Auto Collect Money",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoCollect = Value
    AutoCollect()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Lock Base",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoLock = Value
    AutoLock()
  end
})