local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Neighborhood Tycoon",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Valores
getgenv().AutoUpg = false
getgenv().AutoCollect = false

-- Funções
local function AutoUpg()
  while getgenv().AutoUpg == true do
    pcall(function()
      for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
       if tycoon.OwnerId.Value == eu.UserId then
         for _, button in pairs(tycoon.Buttons:GetChildren()) do
            if button.ShopId.Value == 0 and button.Price.Value <= eu.leaderstats.Cash.Value then
             firetouchinterest(eu.Character.HumanoidRootPart, button.Hit, 0)
             firetouchinterest(eu.Character.HumanoidRootPart, button.Hit, 1)
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
        if tycoon.OwnerId.Value == eu.UserId then
          firetouchinterest(eu.Character.HumanoidRootPart, tycoon.StarterProps.Mailbox.Hitpart, 0)
          firetouchinterest(eu.Character.HumanoidRootPart, tycoon.StarterProps.Mailbox.Hitpart, 1)
        end
      end
    end)
    wait(1)
  end
end

-- workspace.Tycoons["2"].StarterProps.Mailbox.Hitpart
-- workspace.Tycoons["3"].Purchases.expansion1.NPCs.benben_0824.HumanoidRootPart.InteractProx.Enabled = true
-- fireproximityprompt(workspace.Tycoons["3"].Purchases.expansion1.NPCs.benben_0824.HumanoidRootPart.InteractProx)

-- Menu
local Menu = Window:CreateTab("Menu", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Money",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCollect = Value
   	AutoCollect()
   end,
})
local Section = Menu:CreateSection("Upgrade")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Buy Upgrades",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoUpg = Value
   	AutoUpg()
   end,
})