local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Grow a Garden🍅",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoHarvest = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Weight = {
    State = false,
    Min = 1
  }
}

-- Funções
local function AutoHarvest()
  while getgenv().AutoHarvest and task.wait(1) do
    pcall(function()
      for _, farm in pairs(workspace.Farm:GetChildren()) do
        if farm.Important.Data.Owner.Value == eu.Name then
          for _, plant in pairs(farm.Important.Plants_Physical:GetChildren()) do
            for _, pp in pairs(plant.Fruits:GetDescendants()) do
              if pp:IsA("ProximityPrompt") and pp.Enabled == true and (eu.Character.HumanoidRootPart.Position - pp.Parent.Position).Magnitude <= 19 then
                if Settings.Weight.State then
                  if pp.Parent.Parent.Weight.Value >= Settings.Weight.Min then
                    fireproximityprompt(pp)
                  end
                else
                  fireproximityprompt(pp)
                end
                -- print(pp.Parent.Parent.Name)
              end
            end
          end
        end
      end
    end)
  end
end

local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Harvest",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoHarvest = Value
   	AutoHarvest()
   end,
})
Section = Menu:CreateSection("Settings")
Toggle =  Menu:CreateToggle({
   Name = "Min Value to Harvest",
   CurrentValue = false,
   Callback = function(Value)
   	Settings.Weight.State = Value
   end,
})
Input = Menu:CreateInput({
   Name = "Min Kg to Harvest",
   CurrentValue = "1",
   PlaceholderText = "Numbers Only",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	Settings.Weight.Min = tonumber(Text)
   end,
})