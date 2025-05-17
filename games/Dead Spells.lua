local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Dead Spells",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().ESP = false

-- Locals
local eu  = game:GetService("Players").LocalPlayer
local Colors = {
  Enemy = Color3.fromRGB(255, 0, 0),
  Trash = Color3.fromRGB(0, 255, 0)
}

-- Functions
local function ESP()
  local function SetESP(instance, color)
    if instance:FindFirstChid("Luz") then
      if instance.Luz.Enabled == false then
        instance.Luz.Enabled = true
      end
    else
      local highlight = Instance.new("Highlight")
      highlight.FillTransparency = 0.6
      highlight.Adornee, highlight.Parent = instance, instance
      highlight.Name = "Luz"
      highlight.FillColor, highlight.OutlineColor = color, color
    end
  end
  while getgenv().ESP and task.wait(1) do
    if not workspace.Models:GetAttribute("Connected") then
      workspace.Models:SetAttribute("Connected", true)
      workspace.Models.ChildAdded:Connect(function(instance)
        if getgenv().ESP then
          if instance:GetAttribute("Type") == "Enemy" then
            SetESP(instance, Colors.Enemy)
          else
            SetESP(instance, Colors.Trash)
          end
        end
      end)
    end
  end
  if not getgenv().ESP then
    for  _, model in pairs(workspace.Models:GetChildren()) do
      if model:FindFirstChid("Luz") and model.Luz.Enabled == true then
        model.Luz.Enabled = false
      end
    end
  end
end

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
Toggle = VisualTab:CreateToggle({
  Name = "ESP",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().ESP = Value
    ESP()
  end
})
local ColorPicker = VisualTab:CreateColorPicker({
    Name = "Enemy Color",
    Color = Colors.Enemy,
    Callback = function(Value)
    	Colors.Enemy = Value
    end
})
local ColorPicker = VisualTab:CreateColorPicker({
    Name = "Trash Color",
    Color = Colors.Trash,
    Callback = function(Value)
    	Colors.Trash = Value
    end
})