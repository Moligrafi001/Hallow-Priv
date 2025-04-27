local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | PETAPETA",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Valores
getgenv().ItemsESP = false
getgenv().EnemyESP = false
getgenv().AutoInteract = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Colors = {
    Box = Color3.fromRGB(59, 158, 219),
    Zeni = Color3.fromRGB(255, 255, 20),
    Key = Color3.fromRGB(0, 255, 99)
  }
}

-- Funções
local function ItemsESP()
  while getgenv().ItemsESP and task.wait(0.1) do
    for _, item in pairs(workspace.Server.SpawnedItems:GetChildren()) do
      if item:FindFirstChild("Luz") then
        if item.Luz.Enabled == false then
          item.Luz.Enabled = true
        elseif item.Luz.DepthMode ~= Enum.HighlightDepthMode.AlwaysOnTop then
          item.Luz.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        end
      else
        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 0.6
        highlight.Adornee = item
        highlight.Parent = item
        highlight.Name = "Luz"
        
        if string.find(item.Name, "Box") then
          highlight.FillColor, highlight.OutlineColor = Settings.Colors.Box, Settings.Colors.Box
        elseif string.find(item.Name, "Zeni") then
          highlight.FillColor, highlight.OutlineColor = Settings.Colors.Zeni, Settings.Colors.Zeni
        elseif string.find(item.Name, "Key") then
          highlight.FillColor, highlight.OutlineColor = Settings.Colors.Key, Settings.Colors.Key
        else
          highlight.FillColor, highlight.OutlineColor = Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
        end
      end
    end
  end
end
local function EnemyESP()
  while getgenv().EnemyESP and task.wait(0.1) do
    
  end
end
local function AutoInteract()
  while getgenv().AutoInteract and task.wait(0.1) do
    pcall(function()
      for _, pp in pairs(workspace.Server.SpawnedItems:GetDescendants()) do
        if pp:IsA("ProximityPrompt") then
          if (eu.Character.HumanoidRootPart.CFrame.Position - (pp.Parent.Position or pp.Parent.CFrame.Position)).Magnitude <= 9 then
            fireproximityprompt(pp)
          end
        end
      end
    end)
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Toggle = Menu:CreateToggle({
  Name = "ESP Items",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().ItemsESP = Value
    ItemsESP()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Interact",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoInteract = Value
    AutoInteract()
  end
})

-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].HintPaper
-- workspace.Client.Enemy.ClientEnemy.EnemyModel
-- workspace.Server.MapGenerated.Rooms.Room.Props.Safe
-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].Props:GetChildren()[6].tana1.Zeni_2.InteractPoint.ItemInteractP
-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].Props:GetChildren()[6].tana1.InteractPoint.slidePrompt
-- workspace.Server.MapGenerated.Rooms:GetChildren()[8].Props:GetChildren()[6].tana1.Slide.Value