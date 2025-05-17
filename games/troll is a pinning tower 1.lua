local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Troll is a pinning tower 1",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoHit = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Cooldown = 1,
  Reward = "Carpet"
}

-- Functions
local function HitAll()
  pcall(function()
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
      if p ~= eu then
        eu.Character.YeetGlove.Event:FireServer("slash", p.Character, Vector3.new(0, 0, 0))
        eu.Backpack.YeetGlove.Event:FireServer("slash", p.Character, Vector3.new(0, 0, 0))
      end
    end
  end)
end
local function AutoHit()
  while getgenv().AutoHit and task.wait(Settings.Cooldown) do
    HitAll()
  end
end
local function ReturnRewards()
  local Names = {}
  for _, reward in pairs(workspace.MainGame.EndTower.Rewards:GetChildre()) do
    if reward.Name ~= "FaceModel" then
      table.insert(Names, reward.Name)
    end
  end
  return Names
end
local function GetReward()
  eu.Character.HumanoidRootPart:SetAttribute("Pos", eu.Character.HumanoidRootPart.Cframe)
  eu.Character.HumanoidRootPart.Cframe = workspace.MainGame.Rewards[Settings.Reward].ProxmityPromptPart.Cframe
  for _, pp in pairs(workspace.MainGame.Rewards[Settings.Reward]:GetDescendants()) do
    if pp:IsA("ProximityPrompt") then
      fireproximityprompt(pp)
    end
  end
  task.wait(0.1)
  eu.Character.HumanoidRootPart.Cframe = eu.Character.HumanoidRootPart:GetAtribute("Pos")
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Dropdown = Menu:CreateDropdown({
  Name = "Selected Reward",
  Options = ReturnRewards(),
  CurrentOption = { "YeetGlove" },
  Callback = function(Options)
    Settings.Reward = Options[1]
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Hit",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoHit = Value
    AutoHit()
  end
})
Toggle = Menu:CreateButton({
  Name = "Hit All",
  Callback = function(Value)
    HitAll()
  end
})
Section = Menu:CreateLabel("Equip YeetGlove to hit", "triangle-alert")