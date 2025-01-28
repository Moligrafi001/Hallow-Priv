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
local function SetCooldown()
  if not InCooldown then
    InCooldown = true
    wait(3)
    InCooldown = false
  end
end
local function RayOn(part)
  local ray = Ray.new(game.Workspace.CurrentCamera.CFrame.Position, (part.Position - game.Workspace.CurrentCamera.CFrame.Position).unit * 1000)
  local hitPart, hitPosition = workspace:FindPartOnRay(ray, eu.Character)
  if hitPart and hitPart.Parent == part.Parent then
    return true
  end
    return false
end
local function Triggerbot()
  while getgenv().Triggerbot and not InCooldown do
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
      if player ~= eu and player:GetAttribute("Match") == eu:GetAttribute("Match") and player.Team ~= eu.Team and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health >= 1 then
        if not InCooldown and RayOn(player.Character.Head) then
          game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(Vector3.new(-117.68785858154297, 179.37501525878906, -29.733983993530273), Vector3.new(-108.69889831542969, 171.27725219726562, -33.298301696777344), player.Character.Head.Part, Vector3.new(-113.90995788574219, 178.8629608154297, -29.014850616455078))
          SetCooldown()
        end
      end
    end
    wait(1)
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