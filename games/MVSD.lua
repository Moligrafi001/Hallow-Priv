local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Murderers VS Sheriffs Duels",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().HitBox = true
getgenv().Triggerbot = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local InCooldown = false
local HitSize = 9

-- Funções
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentCamera = workspace.CurrentCamera
local InCooldown = false

local function SetCooldown()
  if not InCooldown then
    InCooldown = true
    task.wait(3) -- Substituindo `wait` por `task.wait`, que é mais preciso
    InCooldown = false
  end
end

local function RayOn(part)
  local origin = CurrentCamera.CFrame.Position
  local direction = (part.Position - origin).Unit * 1000

  -- Usando o novo sistema de Raycast
  local rayParams = RaycastParams.new()
  rayParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character} -- Ignorar o próprio personagem
  rayParams.FilterType = Enum.RaycastFilterType.Blacklist

  local result = workspace:Raycast(origin, direction, rayParams)
  if result and result.Instance and result.Instance.Parent == part.Parent then
    return true
  end
  return false
end

local function Triggerbot()
  while getgenv().Triggerbot and not InCooldown do
    for _, player in pairs(Players:GetPlayers()) do
      if player ~= eu and player:GetAttribute("Match") == eu:GetAttribute("Match") and 
         player.Team ~= eu.Team and player.Character and 
         player.Character:FindFirstChild("Humanoid") and 
         player.Character.Humanoid.Health >= 1 then

        if not InCooldown and RayOn(player.Character.Head) then
          -- Certifique-se de usar coordenadas corretas e válidas
          ReplicatedStorage.Remotes.Shoot:FireServer(
            Vector3.new(-117.687, 179.375, -29.734), 
            Vector3.new(-108.699, 171.277, -33.298), 
            player.Character.Head, -- Removendo `.Part`
            Vector3.new(-113.910, 178.863, -29.015)
          )
          SetCooldown()
        end
      end
    end
    task.wait(1) -- Substituindo `wait`
  end
end
local function HitBox()
	while getgenv().HitBox == true do
	  pcall(function()
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= eu and player:GetAttribute("Match") == eu:GetAttribute("Match") and player.Team ~= eu.Team then
				if player.Character then
					if player.Character:FindFirstChild("HumanoidRootPart") then
						if player.Character.HumanoidRootPart.Size ~= Vector3.new(HitSize, HitSize, HitSize) or player.Character.HumanoidRootPart.Transparency ~= 0.6 then
							player.Character.HumanoidRootPart.Size = Vector3.new(HitSize, HitSize, HitSize)
							player.Character.HumanoidRootPart.Transparency = 0.6
							player.Character.HumanoidRootPart.CanCollide = false
						end
					end
				end
			end
		end
	  end)
		wait()
	end
	if getgenv().HitBox == false then
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= game.Players.LocalPlayer then
				if player.Character and game.Players.LocalPlayer.Character then
					if player.Character:FindFirstChild("HumanoidRootPart") then
						if player.Character.HumanoidRootPart.Size ~= Vector3.new(2, 2, 1) or player.Character.HumanoidRootPart.Transparency ~= 0 then
							player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
							player.Character.HumanoidRootPart.Transparency = 0
						end
					end
				end
			end
		end
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Aim Assistant")
Toggle =  Menu:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Triggerbot = Value
   	Triggerbot()
   end,
})
Section = Menu:CreateSection("Hitbox Expander")
Input = Menu:CreateInput({
   Name = "Hitbox Size",
   CurrentValue = "",
   PlaceholderText = "Default HitBox Size = 9",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	HitSize = Text
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Expand Hitboxes",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().HitBox = Value
   	HitBox()
   end,
})