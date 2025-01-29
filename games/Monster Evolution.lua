local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Monster Evolution",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoAttack = false
getgenv().AutoRebirth = false

-- Locais
local LongeMax = 15
local VidaMax = 300
local VidaMin = 0
local RebirthMin = 30
local ModoAtaque = "Nenhum"
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function AutoAttack()
  if getgenv().AutoAttack and ModoAtaque == "Nenhum" then
    Rayfield:Notify({
      Title = "No Attack Mode Selected!",
      Content = "Select it before you attack!",
      Duration = 3,
      Image = 17091459839,
    })
  end
  while getgenv().AutoAttack do
    pcall(function()
      for _, mob in pairs(workspace:GetChildren()) do
        if mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.MaxHealth <= VidaMax and mob.Humanoid.MaxHealth >= VidaMin then
          if ModoAtaque == "Aura" then
            local distance = (eu.Character.HumanoidRootPart.CFrame.Position - mob.HumanoidRootPart.CFrame.Position).Magnitude
            if distance <= LongeMax then
              game:GetService("ReplicatedStorage").Packages.Knit.Services.MonsterService.RF.RequestAttack:InvokeServer(mob.HumanoidRootPart.CFrame)
              break
            end
          elseif ModoAtaque == "Teleport" then
            eu.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
            wait(0.1)
            game:GetService("ReplicatedStorage").Packages.Knit.Services.MonsterService.RF.RequestAttack:InvokeServer(mob.HumanoidRootPart.CFrame)
            break
          end
        end
      end
    end)
    wait(0.1)
  end
end
local function AutoRebirth()
  while getgenv().AutoRebirth do
    pcall(function()
      if eu.leaderstats.Level.Value >= RebirthMin then
        game:GetService("ReplicatedStorage").Packages.Knit.Services.RebirthService.RF.RequestRebirth:InvokeServer()
      end
    end)
    wait(0.33)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Dropdown = Menu:CreateDropdown({
   Name = "Attack Mode",
   Options = {"Aura", "Teleport"},
   CurrentOption = {"Select Attack Mode"},
   MultipleOptions = false,
   Callback = function(Options)
   		ModoAtaque = Options[1]
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Attack",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoAttack = Value
   	AutoAttack()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoRebirth = Value
   	AutoRebirth()
   end,
})
Section = Menu:CreateSection("Settings")
Input = Menu:CreateInput({
   Name = "Max HP to Attack",
   CurrentValue = "300",
   PlaceholderText = "Number here",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	VidaMax = tonumber(Text)
   end,
})
Input = Menu:CreateInput({
   Name = "Min HP to Attack",
   CurrentValue = "0",
   PlaceholderText = "Number here",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	VidaMin = tonumber(Text)
   end,
})
Input = Menu:CreateInput({
   Name = "Max Aura Distance",
   CurrentValue = "15",
   PlaceholderText = "Number here",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	LongeMax = tonumber(Text)
   end,
})
Input = Menu:CreateInput({
   Name = "Min Level to Rebirth",
   CurrentValue = "30",
   PlaceholderText = "Number here",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	RebirthMin = tonumber(Text)
   end,
})