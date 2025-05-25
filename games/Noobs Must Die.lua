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
  Distance = 30
}

-- Functios
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
  Callback = function(Value)
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

for i = 1, 39 do
local args = {
    [1] = "Cake"
}

game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer(unpack(args))
task.wait(0.1)
end
game:GetService("ReplicatedStorage").PlrMan.Items:GetChildren() Part
local args = {
    [1] = "Disruptor"
}

game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer(unpack(args))
local args = {
    [1] = "Armor"
}

game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer(unpack(args))
local args = {
    [1] = "Windforce"
}

game:GetService("ReplicatedStorage").PlrMan.Items.PickupItem:FireServer(unpack(args))
local args = {
    [1] = 2,
    [2] = math.huge
}

game:GetService("ReplicatedStorage").PlrMan.LogQuestProgress:FireServer(unpack(args))
