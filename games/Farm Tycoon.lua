local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Farm Tycoon",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

-- Valores
getgenv().AutoCollect = false
getgenv().AutoBuy = false

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function AutoBuy()
  while getgenv().AutoBuy == true do
    pcall(function()
      for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
        if tycoon.Name == eu.Name .. "'s Tycoon" then
          for _, button in pairs(tycoon.Buttons:GetChildren()) do
            if button:GetAttribute("Cost") <= eu.leaderstats.Money.Value then
              firetouchinterest(eu.Character.HumanoidRootPart, button.NeonTop, 0)
              firetouchinterest(eu.Character.HumanoidRootPart, button.NeonTop, 1)
              break
            end
          end
        end
      end
    end)
    wait(1)
  end
end
local function AutoCollect()
  while getgenv().AutoCollect == true do
    pcall(function()
      for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
        if tycoon.Name == eu.Name .. "'s Tycoon" then
          firetouchinterest(eu.Character.HumanoidRootPart, tycoon.Unlockables["Cash Collector"].CollectorGreen.CollectPart, 0)
          firetouchinterest(eu.Character.HumanoidRootPart, tycoon.Unlockables["Cash Collector"].CollectorGreen.CollectPart, 1)
        end
      end
    end)
    wait(1)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Gun Features")
Button = Menu:CreateButton({
   Name = "Kill All",
   Callback = function()
   	KillGun()
   end,
})