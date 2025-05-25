local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Noobs Must Die",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoKill = false
getgenv().KillAura = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Distance = 30,
  Selected = "Armor",
  Times = 1
}

-- Functios
local function GetItem()
  for i = 1, Settings.Selected do
    game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer(Settings.Selected)
    task.wait(0.1)
  end
end
local function ReturnItems()
  local Names = {}
  
  for _, item in pairs(game:GetService("ReplicatedStorage").PlrMan.Items:GetChildren()) do
    if item:IsA("Part") then
      table.insert(Names, item.Name)
    end
  end
  
  return Names
end
local function KillAll()
  for _, enemy in pairs(workspace.Enemies:GetChildren()) do
    game:GetService("ReplicatedStorage").HurtEnemy:FireServer(enemy, math.huge)
  end
end
local function AutoKill()
  while getgenv().AutoKill and task.wait(1) do
    KillAll()
  end
end
local function KillAura()
  local function GetNearby()
    local Detected = {}
    for _, enemy in pairs(workspace:GetPartBoundsInBox(eu.Character.HumanoidRootPart.CFrame, Vector3.new(Settings.Distance, 20, Settings.Distance), nil)) do
      local model = enemy:FindFirstAncestorWhichIsA("Model")
      if model:IsDescendantOf(workspace.Enemies) then
        table.insert(Detected, enemy)
      end
    end
    return Detected
  end
  while getgenv().KillAura and task.wait(0.1) do
    pcall(function()
      for _, enemy in pairs(GetNearby()) do
        game:GetService("ReplicatedStorage").HurtEnemy:FireServer(enemy, math.huge)
      end
    end)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Exterminate")
Button = Menu:CreateButton({
  Name = "Kill All",
  Callback = function()
    KillAll()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Kill",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoKill = Value
    AutoKill()
  end
})
Section = Menu:CreateSection("Helpful")
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
   CurrentValue = tostring(Settings.Distance / 2),
   PlaceholderText = "Numbers only, ex.: 15",
   Callback = function(Text)
     Settings.Distance = tonumber(Text) * 2
   end,
})
Button = Menu:CreateButton({
  Name = "Finish All Quests",
  Callback = function()
    for i = 1, 9 do
      game:GetService("ReplicatedStorage").PlrMan.LogQuestProgress:FireServer(i, math.huge)
    end
  end
})

-- Items
local ItemsTab = Window:CreateTab("Items", "box")
Section = ItemsTab:CreateSection("Settings")
Dropdown = ItemsTab:CreateDropdown({
  Name = "Selected Item",
  Options = ReturnItems(),
  CurrentOption = { Settings.Selected },
  Callback = function(Options)
    Settings.Selected = Options[1]
  end
})
Input = ItemsTab:CreateInput({
   Name = "Selected Amount",
   CurrentValue = tostring(Settings.Times),
   PlaceholderText = "Numbers only, ex.: 15",
   Callback = function(Text)
     Settings.Times = tonumber(Text)
   end,
})
Section = ItemsTab:CreateSection("Initialize")
Button = ItemsTab:CreateButton({
  Name = "Get Selected Item",
  Callback = function()
    GetItem()
  end
})