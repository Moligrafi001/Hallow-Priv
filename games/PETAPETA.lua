
-- Valores
getgenv().ItemsESP = false
getgenv().EnemyESP = false
getgenv().AutoInteract = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Colors = {
    Box = Color3.fromRGB(59, 158, 219),
    Zeni = Color3.fromRGB(255, 255, 20)
  }
}

-- Funções
local function ItemsESP()
  while getgenv().ItemsESP and task.wait(0.1) do
    for _, item in pairs(workspace.Server.SpawnedItems:GetChildren()) do
      if item:FindFirstChildOfClass("Highlight") then
        
      else
        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 0.6
        highlight.Adornee = item
        highlight.Parent = item
        
        if string.find(item.Name, "Box") then
          highlight.FillColor, highlight.OutlineColor = Settings.Colors.Box, Settings.Colors.Box
        elseif string.find(item.Name, "Zeni") then
          highlight.FillColor, highlight.OutlineColor = Settings.Colors.Zeni, Settings.Colors.Zeni
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
    for _, item in pairs(workspace.Server.SpawnedItems:GetChildren()) do
      fireproximityprompt(item:FindFirstChildOfClass("ProximityPrompt", true))
    end
  end
end