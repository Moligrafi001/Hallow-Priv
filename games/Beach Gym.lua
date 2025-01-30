local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | BaBGaPBW",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoTrain = false
getgenv().AutoBuy = false

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function AutoTrain()
  while getgenv().AutoTrain do
    game:GetService("ReplicatedStorage").Remotes.Trick:FireServer("Train")
    wait(0.1)
  end
end
-- workspace.Tycoons["3"].Buttons["Pullups Fanum"].Touch.Attachment.ParticleEmitter
local function AutoBuy()
  while getgenv().AutoBuy do
    for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
      if tycoon:GetAttribute("Owner") == eu.Name then
        for _, button in pairs(tycoon.Buttons:GetChildren()) do
          if button.Touch.Transparency == 0 and button.Touch.Color == Color3.fromRGB(34, 159, 61) and not button.Touch:FindFirstChild("Attachment") then
            firetouchinterest(eu.Character.HumanoidRootPart, button.Touch, 0)
            firetouchinterest(eu.Character.HumanoidRootPart, button.Touch, 1)
            break
          end
        end
      end
    end
    wait(1)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Train",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoTrain = Value
   	AutoTrain()
   end,
})
Section = Menu:CreateSection("Upgrade")
Toggle =  Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoBuy = Value
   	AutoBuy()
   end,
})