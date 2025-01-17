-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Evo%20Tycoon.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Evo Tycoon",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
getgenv().SetWalkSpeed = false
getgenv().SetJumpPower = false
getgenv().InfJump = false
getgenv().NoClip = false
local function SetWalkSpeed()
	while getgenv().SetWalkSpeed == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
		end
		wait(0.01)
	end
	if getgenv().SetWalkSpeed == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end
local function SetJumpPower()
	while getgenv().SetJumpPower == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower ~= JumpPowerText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = JumpPowerText
		end
		wait(0.01)
		end
	if getgenv().SetJumpPower == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
	end
end
local function InfJump()
	while getgenv().InfJump == true do
		game:GetService("UserInputService").JumpRequest:connect(function()
			if getgenv().InfJump == true then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
		wait(0.1)
	end
end
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

-- Variáveis
getgenv().AutoCollect = false
getgenv().AutoBuy = false
getgenv().AntiLasers = false
getgenv().StealWepe = false
getgenv().PlayerESP = false
getgenv().HitBox = false
getgenv().AntiDamage = false

-- Locais
local HitSize = 10
local CorInocente = Color3.fromRGB(255, 125, 0)

-- Funções
local function AutoCollect()
	local eumesmo = game.Players.LocalPlayer
	local function getCharacter()
	return eumesmo.Character or eumesmo.CharacterAdded:Wait()
	end
	local function getHumanoid()
		local character = getCharacter()
		return character:WaitForChild("Humanoid")
	end
	local function getHRP()
		local character = getCharacter()
		return character:WaitForChild("HumanoidRootPart")
	end
	local function checkGenerators(gen, HRP)
		for i = 1, 5 do
			local generatorName = "Generator" .. string.char(64 + i)
			for gera = 1, 4 do
				local final = generatorName .. gera
				if gen.Name == final then
					if gen:FindFirstChild("Ching") then
						firetouchinterest(HRP, gen.Ching, 0)
						firetouchinterest(HRP, gen.Ching, 1)
					end
				end
			end
			for gera = 1, 4 do
				local final = "GeneratorT" .. gera
				if gen.Name == final then
					if gen:FindFirstChild("Ching") then
						firetouchinterest(HRP, gen.Ching, 0)
						firetouchinterest(HRP, gen.Ching, 1)
					end
				end
			end
			for gera = 1, 4 do
				local final = "Generator" .. gera
				if gen.Name == final then
					if gen:FindFirstChild("Ching") then
						firetouchinterest(HRP, gen.Ching, 0)
						firetouchinterest(HRP, gen.Ching, 1)
					end
				end
			end
		end
	end
	while getgenv().AutoCollect do
    local character = getCharacter()
		local humanoid = getHumanoid()
		local HRP = getHRP()
		for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
			if tycoon.Owner.Value == eumesmo.Name then
				for _, gen in pairs(tycoon:GetChildren()) do
					if workspace:FindFirstChild(eumesmo.Name) then
						if humanoid.Health >= 1 then
							if character:FindFirstChild("HumanoidRootPart") then
								checkGenerators(gen, HRP)
							end
						end
					end
				end
			end
		end
		wait(1)
	end
end
local function AntiLasers()
	while getgenv().AntiLasers == true do
		for _, tycoons in pairs(workspace.Tycoons:GetChildren()) do
			if tycoons:FindFirstChild("LaserDoor") then
				if tycoons.LaserDoor:FindFirstChild("Part3") then
					if tycoons.LaserDoor.Part3.CanTouch == true then
						tycoons.LaserDoor.Part3.CanTouch = false
					end
				end
			end
		end
		wait(0.01)
	end
	if getgenv().AntiLasers == false then
		for _, tycoons in pairs(workspace.Tycoons:GetChildren()) do
			if tycoons:FindFirstChild("LaserDoor") then
				if tycoons.LaserDoor:FindFirstChild("Part3") then
					if tycoons.LaserDoor.Part3.CanTouch == false then
						tycoons.LaserDoor.Part3.CanTouch = true
					end
				end
			end
		end
	end
end
local function StealWepe()
	pcall(function()
		while getgenv().StealWepe == true do
			for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
				for _, power in pairs(tycoon:GetChildren()) do
					if power:IsA("Model") and power:FindFirstChild("Part2") then
						for i = 1, 5 do
							local quase = "Power" .. string.char(64 + i)
							for v = 1, 3 do
								local final = quase .. v
								local gozadinha = "Power" .. v
								local paugrosso = "PowerT" .. v
								if power.Name == gozadinha then
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, power.Part2, 0)
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, power.Part2, 1)
								end
								if power.Name == final then
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, power.Part2, 0)
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, power.Part2, 1)
								end
								if power.Name == paugrosso then
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, power.Part2, 0)
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, power.Part2, 1)
								end
							end
						end
					end
				end
			end
		wait(1)
		end
	end)
end
local function PlayerESP()
	while getgenv().PlayerESP == true do
		for _, player in pairs(workspace:GetChildren()) do
			if player:FindFirstChild("Humanoid") and player:FindFirstChild("Health") then
				if player.Name ~= game.Players.LocalPlayer.Name then
					if player:FindFirstChild("Highlight") then
						if player.Highlight.Enabled == false then
							player.Highlight.Enabled = true
						end
						if player.Highlight.FillColor ~= CorInocente or player.Highlight.OutlineColor ~= CorInocente then
							player.Highlight.FillColor = CorInocente
							player.Highlight.OutlineColor = CorInocente
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.FillColor = CorInocente
						highlight.OutlineColor = CorInocente
						highlight.FillTransparency = 1
						highlight.Adornee = player
						highlight.Parent = player
					end
				end
			end
		end
		wait(0.33)
	end
	for _, player in pairs(workspace:GetChildren()) do
		if player:FindFirstChild("Humanoid") and player:FindFirstChild("Health") then
			if player.Name ~= game.Players.LocalPlayer.Name then
				if player:FindFirstChild("Highlight") then
					player.Highlight.Enabled = false
				end
			end
		end
	end
end
local function AutoBuy()
	local eumesmo = game.Players.LocalPlayer
	local function getCharacter()
	return eumesmo.Character or eumesmo.CharacterAdded:Wait()
	end
	local function getHumanoid()
		local character = getCharacter()
		return character:WaitForChild("Humanoid")
	end
	local function getHRP()
		local character = getCharacter()
		return character:WaitForChild("HumanoidRootPart")
	end
	while getgenv().AutoBuy == true do
		local character = getCharacter()
		local humanoid = getHumanoid()
		local HRP = getHRP()
		if humanoid and humanoid.Health > 0 then
			for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
				if tycoon.Owner.Value == eumesmo.Name then
					for _, botao in pairs(tycoon:GetChildren()) do
						if botao:IsA("Model") then
							if botao:FindFirstChild("Part1") then
								if botao.Part1:FindFirstChild("BillboardGui2") then
									if botao.Part1.BillboardGui2:FindFirstChild("TextLabel") then
										local numero = tonumber(botao.Part1.BillboardGui2.TextLabel.Text:gsub("[^%d]", ""):match("%d+"))
										if numero <= game.Players.LocalPlayer.leaderstats.Cash.Value then
											for _, tt in pairs(botao:GetDescendants()) do
												if tt.Name == "TouchInterest" then
													firetouchinterest(HRP, tt.Parent, 0)
													firetouchinterest(HRP, tt.Parent, 1)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		wait(0.33)
	end
end
local function HitBox()
	while getgenv().HitBox == true do
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= game.Players.LocalPlayer then
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
			wait(0.01)
		end
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
local function AntiDamage()
	while getgenv().AntiDamage == true do
		for _, pega in pairs(workspace.SpecialEffects:GetChildren()) do
			for _, ti in pairs(pega:GetDescendants()) do
				if ti.Name == "TouchInterest" then
					if ti.Parent.CanTouch == true then
						ti.Parent.CanTouch = false
					end
				end
			end
		end
		wait(0.01)
	end
	if getgenv().AntiDamage == false then
		for _, pega in pairs(workspace.SpecialEffects:GetChildren()) do
			for _, ti in pairs(pega:GetDescendants()) do
				if ti.Name == "TouchInterest" then
					if ti.Parent.CanTouch == false then
						ti.Parent.CanTouch = true
					end
				end
			end
		end
	end
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
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
   	getgenv().AutoBuy = Value
   	AutoBuy()
   end,
})
local Section = Menu:CreateSection("Helpful")
local Toggle =  Menu:CreateToggle({
   Name = "Steal Weapons",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().StealWepe = Value
   	StealWepe()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Anti Doors Lasers",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiLasers = Value
   	AntiLasers()
   end,
})

-- Combat		
local CombatTab = Window:CreateTab("Combat", "swords")
local Section = CombatTab:CreateSection("Blatant")
local Toggle =  CombatTab:CreateToggle({
   Name = "Anti Special Damage",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiDamage = Value
   	AntiDamage()
   end,
})
local Section = CombatTab:CreateSection("ESP")
local Toggle =  CombatTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PlayerESP = Value
   	PlayerESP()
   end,
})
local ColorPicker = CombatTab:CreateColorPicker({
    Name = "Innocent Color",
    Color = CorInocente,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorInocente = Value
    end
})
local Section = CombatTab:CreateSection("Hitbox Expander")
local Input = CombatTab:CreateInput({
   Name = "Hitbox Size",
   CurrentValue = "",
   PlaceholderText = "Default HitBox Size = 10",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	HitSize = Text
   end,
})
local Toggle =  CombatTab:CreateToggle({
   Name = "Expand Hitboxes",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().HitBox = Value
   	HitBox()
   end,
})

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
local Section = MoveTab:CreateSection("Walk")
local Input = MoveTab:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
local Section = MoveTab:CreateSection("Jump")
local Input = MoveTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})