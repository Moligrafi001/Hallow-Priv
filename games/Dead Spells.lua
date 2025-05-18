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

-- Movement
local MovementTexts = {
  WalkSpeedText = 16,
  JumpPowerText = 50
}
getgenv().SetWalkSpeed = false
getgenv().SetJumpPower = false
getgenv().InfJump = false
getgenv().NoClip = false
local function SetWalkSpeed()
  while getgenv().SetWalkSpeed and task.wait(1) do
    pcall(function()
      local function CheckSet()
        if eu.Character.Humanoid.WalkSpeedText ~= MovementTexts.WalkSpeedText then
          eu.Character.Humanoid.WalkSpeedText = MovementTexts.WalkSpeedText
        end
      end
      CheckSet()
      if not eu.Character.Humanoid:GetAttribute("SpeedConnected") then
        eu.Character.Humanoid:SetAttribute("SpeedConnected", true)
        eu.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
          if getgenv().SetWalkSpeed then CheckSet() end
        end)
      end
		end)
  end
end
local function SetJumpPower()
  while getgenv().SetJumpPower and task.wait(1) do
    pcall(function()
      local function CheckSet()
        if eu.Character.Humanoid.JumpPower ~= MovementTexts.JumpPowerText then
          eu.Character.Humanoid.JumpPowerText = MovementTexts.JumpPowerText
        end
      end
      CheckSet()
      if not eu.Character.Humanoid:GetAttribute("JumpConnected") then
        eu.Character.Humanoid:SetAttribute("JumpConnected", true)
        eu.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
          if getgenv().SetJumpPower then CheckSet() end
        end)
      end
		end)
  end
end
local function InfJump()
  while getgenv().InfJump and task.wait(1) do
    if not game:GetService("UserInputService"):GetAttribute("JumpConnected") then
      game:GetService("UserInputService"):SetAttribute("JumpConnected", true)
      game:GetService("UserInputService").JumpRequest:Connect(function()
        if getgenv().InfJump then
         eu.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
        end
      end)
    end
	end
end
local function NoClip()
	while getgenv().NoClip and wait(0.1) do
	  pcall(function()
  		for _, part in pairs(eu.Character:GetDescendants()) do
  			if part:IsA("BasePart") then
  				if getgenv().NoClip then
  					part.CanCollide = false
  				else
  					part.CanCollide = true
  				end
  			end
  		end
		end)
	end
end

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
Section = MoveTab:CreateSection("Walk")
Input = MoveTab:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	MovementTexts.WalkSpeedText = tonumber(Text)
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
Section = MoveTab:CreateSection("Jump")
Input = MoveTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	MovementTexts.JumpPowerText = tonumber(Text)
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})