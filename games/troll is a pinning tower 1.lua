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
getgenv().AutoTeleport = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Cooldown = 1,
  HitMode = "Push Up",
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
  local function Middle(who)
    eu.Character.HumanoidRootPart.CFrame = workspace.MainGame.EndTower.Rewards[who].ProximityPrompPart.CFrame
    task.wait(0.3)
    for _, pp in pairs(workspace.MainGame.EndTower.Rewards[who]:GetDescendants()) do
      if pp:IsA("ProximityPrompt") then
        fireproximityprompt(pp)
      end
    end
  end
  eu.Character.HumanoidRootPart:SetAttribute("Pos", eu.Character.HumanoidRootPart.CFrame)
  if manual then
    Middle(manual)
  else
    Middle(Settings.Reward)
  end
  eu.Character.HumanoidRootPart.CFrame = eu.Character.HumanoidRootPart:GetAttribute("Pos") * CFrame.new(0, 1, 0)
end
local function HitAll()
  pcall(function()
    local function Hit()
      for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= eu then
          pcall(function()
            if Settings.HitMode == "Push Up" then
              eu.Character.YeetGlove.Event:FireServer("slash", p.Character, Vector3.new(0, 0, 0))
            else
              eu.Character.YeetGlove.Event:FireServer("slash", p.Character, eu.Character.HumanoidRootPart.CFrame.Position)
            end
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
local function TeleportAndPressE()
    task.spawn(function()
        while getgenv().AutoTeleport do
            local player = game:GetService("Players").LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            hrp.CFrame = CFrame.new(
                -212.457565, 530.234497, -1843.7771,
                -0.00445137778, 5.40920775e-09, -0.999990106,
                 1.7387547e-10, 1, 5.40848744e-09,
                 0.999990106, -1.49798535e-10, -0.00445137778
            )

            task.wait(0.2)

            -- Simulate pressing E
            local virtualInputManager = game:GetService("VirtualInputManager")
            virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.05)
            virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)

            task.wait(1) 
        end
    end)
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
Menu:CreateToggle({
    Name = "Auto Win",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoTeleport = Value
        if Value then
            TeleportAndPressE()
        end
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
Dropdown = Menu:CreateDropdown({
  Name = "Hit Mode",
  Options = { "Push Up", "Crash" },
  CurrentOption = { "Push Up" },
  Callback = function(Options)
    Settings.HitMode = Options[1]
  end
})
Input = Menu:CreateInput({
   Name = "Auto Hit Cooldown",
   CurrentValue = "0.5",
   PlaceholderText = "Seconds only, ex.: 0.5",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
     Settings.Cooldown = tonumber(Text)
   end,
})