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
  Melee = Color3.fromRGB(0, 0, 255),
  Trash = Color3.fromRGB(0, 255, 0)
}

-- Functions
local function ESP()
  local function SetESP(instance, color)
    if instance:FindFirstChild("Luz") then
      if instance.Luz.Enabled == false then
        instance.Luz.Enabled = true
      end
    else
      local highlight = Instance.new("Highlight")
      highlight.FillTransparency = 1
      highlight.Adornee, highlight.Parent = instance, instance
      highlight.Name = "Luz"
      highlight.FillColor, highlight.OutlineColor = color, color
    end
  end
  local function Check(instance)
    pcall(function()
      if instance:FindFirstChild(instance.Name) and instance[instance.Name]:GetAttribute("Type") then
        return instance[instance.Name]:GetAttribute("Type")
      elseif instance:FindFirstChild("Configuration") and instance.Configuration:GetAttribute("Type") then
        return instance.Configuration:GetAttribute("Type")
      end
      return false
    end)
  end
  while getgenv().ESP and task.wait(1) do
    if not workspace.Models:GetAttribute("Connected") then
      workspace.Models:SetAttribute("Connected", true)
      workspace.Models.ChildAdded:Connect(function(instance)
        if getgenv().ESP then
          local obj = Check(instance)
          if obj then
            if obj == "Enemy" then
              SetESP(instance, Colors.Enemy)
            elseif obj == "Melee" then
              SetESP(instance, Colors.Melee)
            else
              SetESP(instance, Colors.Trash)
            end
          else
            SetESP(instance, Colors.Trash)
          end
        end
      end)
    end
  end
  if not getgenv().ESP then
    for  _, model in pairs(workspace.Models:GetChildren()) do
      if model:FindFirstChild("Luz") and model.Luz.Enabled == true then
        model.Luz.Enabled = false
      end
    end
  end
end

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
Section = VisualTab:CreateSection("Undetectable")
Toggle = VisualTab:CreateToggle({
  Name = "Highlights ESP",
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
    Name = "Melee Color",
    Color = Colors.Melee,
    Callback = function(Value)
    	Colors.Melee = Value
    end
})
local ColorPicker = VisualTab:CreateColorPicker({
    Name = "Trash Color",
    Color = Colors.Trash,
    Callback = function(Value)
    	Colors.Trash = Value
    end
})

-- Teleport
-- local TPsTab = Window:CreateTab("Teleport", "Shell")