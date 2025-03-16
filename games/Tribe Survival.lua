local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Tribe Survival🏝️",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Movement
getgenv().NoClip = false
local function NoClip()
	while getgenv().NoClip == true do
		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if getgenv().NoClip then
					part.CanCollide = false
				else
					part.CanCollide = true
				end
			end
		end
		wait(0.1)
	end
end

-- Valores
getgenv().AntiWolf = false
getgenv().AntiSpike = false
getgenv().AutoEat = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  EatCooldown = 0.1,
  EatMin = 69
}

-- Funčões
local function AntiWolf()
  local function SetBite(state)
    pcall(function()
      for _, touch in pairs(workspace.Character:GetDescendants()) do
        if touch:IsA("TouchTransmitter") and touch.Parent:IsA("BasePart") and touch.Parent.Name == "Hitbox" and touch.Parent.CanTouch ~= state then
          touch.Parent.CanTouch = state
        end
      end
    end)
  end
  while getgenv().AntiWolf and task.wait(0.333) do
    SetBite(false)
  end
  if not getgenv().AntiWolf then
    SetBite(true)
  end
end
local function AntiSpike()
  local function SetSpike(state)
    pcall(function()
      for _, touch in pairs(workspace.Structures:GetDescendants()) do
        if touch:IsA("TouchTransmitter") and touch.Parent:IsA("BasePart") and touch.Parent.Name == "Touchy" and touch.Parent.CanTouch ~= state then
          touch.Parent.CanTouch = state
        end
      end
      for _, touch in pairs(workspace.Resources:GetDescendants()) do
        if touch:IsA("TouchTransmitter") and touch.Parent:IsA("BasePart") and touch.Parent.Name == "Touchy" and touch.Parent.CanTouch ~= state then
          touch.Parent.CanTouch = state
        end
      end
    end)
  end
  while getgenv().AntiSpike and task.wait(0.333) do
    SetSpike(false)
  end
  if not getgenv().AntiSpike then
    SetSpike(true)
  end
end
local function AutoEat()
  while getgenv().AutoEat and task.wait(Settings.EatCooldown) do
    pcall(function()
      if eu.Character.Humanoid.Health <= Settings.EatMin then
        for _, food in pairs(eu.Backpack:GetChildren()) do
          if food:IsA("Tool") and food:FindFirstChild("FoodScripts") and food.FoodScripts:FindFirstChild("Eat") and food:FindFirstChild("Stats") and food.Stats:GetAttribute("FoodCost") <= eu.Character.Resources:GetAttribute("Food") then
            print(workspace.Characters.HallowHubby.Resources:GetAttribute("Food"))
            print(game:GetService("Players").LocalPlayer.Backpack.Apple.Stats:GetAttribute("FoodCost"))
            food.Parent = eu.Character
            food.FoodScripts.Eat:FireServer()
            food.Parent = eu.Backpack
          end
        end
      end
    end)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Anti Damage")
Toggle =  Menu:CreateToggle({
   Name = "Anti Spikes",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiSpike = Value
   	AntiSpike()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Anti Wolfs",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiWolf = Value
   	AntiWolf()
   end,
})
Section = Menu:CreateSection("Auto Eat")
Toggle =  Menu:CreateToggle({
   Name = "Auto Eat Food",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoEat = Value
   	AutoEat()
   end,
})
Input = Menu:CreateInput({
   Name = "Eat Food Cooldown",
   CurrentValue = "0.1",
   PlaceholderText = "Value in number",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	Settings.EatCooldown = tonumber(Text)
   end,
})
Input = Menu:CreateInput({
   Name = "Min HP to Eat",
   CurrentValue = "69",
   PlaceholderText = "Value in number",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	Settings.EatMin = tonumber(Text)
   end,
})

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
Section = MoveTab:CreateSection("Walk")
Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})

-- game:GetService("Players").LocalPlayer.Character.Apple.FoodScripts.Eat:FireServer()
-- game:GetService("Players").LocalPlayer.Backpack.Apple.FoodScripts.Eat
-- game:GetService("Players").LocalPlayer.Backpack.Greataxe.ToolScripts.Swing
-- RemoteEvent
-- workspace.Resources:GetChildren()[194].Touchy.TouchInterest
-- workspace.Characters.Wolf.Hitbox.TouchInterest
-- workspace.Structures:GetChildren()[249].Touchy.TouchInterest