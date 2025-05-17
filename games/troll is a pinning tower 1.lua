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
local function ReturnRewards()
  local Names = {}
  for _, reward in pairs(workspace.MainGame.EndTower.Rewards:GetChildren()) do
    if reward.Name ~= "FaceModel" then
      table.insert(Names, reward.Name)
    end
  end
  return Names
end
local function GetReward(manual)
  eu.Character.HumanoidRootPart:SetAttribute("Pos", eu.Character.HumanoidRootPart.CFrame)
  if manual then
    eu.Character.HumanoidRootPart.CFrame = workspace.MainGame.EndTower.Rewards[manual].ProximityPrompPart.CFrame
  else
    eu.Character.HumanoidRootPart.CFrame = workspace.MainGame.EndTower.Rewards[Settings.Reward].ProximityPrompPart.CFrame
  end
  for _, pp in pairs(workspace.MainGame.EndTower.Rewards[Settings.Reward]:GetDescendants()) do
    if pp:IsA("ProximityPrompt") then
      fireproximityprompt(pp)
    end
  end
  task.wait(0.1)
  eu.Character.HumanoidRootPart.CFrame = eu.Character.HumanoidRootPart:GetAtribute("Pos")
end
local function HitAll()
  pcall(function()
    local function Hit()
      for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= eu then
          pcall(function()
            eu.Character.YeetGlove.Event:FireServer("slash", p.Character, Vector3.new(0, 0, 0))
          end)
        end
      end
    end
    if eu.Character:FindFirstChild("YeetGlove") then
      Hit()
    else
      if eu.Backpack:FindFirstChild("YeetGlove") then
        eu.Backpack.YeetGlove.Parent = eu.Character
        Hit()
      else
        GetReward("SteamPunk")
      end
    end
  end)
end
local function AutoHit()
  while getgenv().AutoHit and task.wait(Settings.Cooldown) do
    HitAll()
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Dropdown = Menu:CreateDropdown({
  Name = "Selected Reward",
  Options = ReturnRewards(),
  CurrentOption = { "SteamPunk" },
  Callback = function(Options)
    Settings.Reward = Options[1]
  end
})
Button = Menu:CreateButton({
  Name = "Get Reward",
  Callback = function(Value)
    GetReward()
  end
})
Section = Menu:CreateSection("Blatant")
Toggle = Menu:CreateToggle({
  Name = "Auto Hit",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoHit = Value
    AutoHit()
  end
})
Button = Menu:CreateButton({
  Name = "Hit All",
  Callback = function(Value)
    HitAll()
  end
})