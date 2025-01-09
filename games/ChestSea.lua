-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/ChestSea.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Fruit Reborn",
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
getgenv().AutoChest = false
getgenv().PlayerESP = false
getgenv().ChestsESP = false
getgenv().Fullbright = false
getgenv().AutoMobs = false

-- Locais
local SelectedMob = "No Mob Selected"

-- Funções
local function AutoChest()
	while getgenv().AutoChest == true do
		for _, chest in pairs(workspace.Chest:GetChildren()) do
			if chest:IsA("Model") then
				for numero = 1, 2 do
					local final = "Chest" .. numero .. "base1"
					if chest:FindFirstChild(final) and workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
						game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("Hallow_Hub", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chest[final].CFrame
						wait(0.7)
						for _, pp in pairs(chest:GetDescendants()) do
							if pp:IsA("ProximityPrompt") then
								fireproximityprompt(pp)
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("Hallow_Hub")
							break
							end
						end
					break
					end
				end
			end
			wait(0.2)
		end
	end
end
local function PlayerESP()
	while getgenv().PlayerESP == true do
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player then
				if player ~= game.Players.LocalPlayer.Character then
					if player:FindFirstChild("LuzESP") then
						if player.LuzESP.Enabled == false then
							player.LuzESP.Enabled = true
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.Name = "LuzESP"
						highlight.FillColor = Color3.fromRGB(255, 125, 0)
						highlight.OutlineColor = Color3.fromRGB(255, 125, 0)
						highlight.FillTransparency = 0.6
						highlight.Adornee = player
						highlight.Parent = player
					end
					if player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Head") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local distance = player.Name .. " [" .. math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.HumanoidRootPart.Position).Magnitude) .. " Studs]"
						if player.Head:FindFirstChild("NameESP") then
							if player.Head.NameESP.TextESP.Text ~= distance then
								player.Head.NameESP.TextESP.Text = distance
							end
						else
							local bgui = Instance.new("BillboardGui", player.Head)
	            bgui.Name = "NameESP"
	            bgui.AlwaysOnTop = true
	            bgui.ExtentsOffset = Vector3.new(0, 3, 0)
	            bgui.Size = UDim2.new(0, 200, 0, 50)
	            bgui.MaxDistance = 1500
	            if not player.Head.NameESP:FindFirstChild("TextESP") then
	            	local nam = Instance.new("TextLabel", bgui)
	            	nam.Name = "TextESP"
	            	nam.Text = distance
	            	nam.BackgroundTransparency = 1
	            	nam.TextSize = 15
	            	nam.Font = Enum.Font.GothamBold
	            	nam.TextColor3 = Color3.fromRGB(255, 125, 0)
	            	nam.Size = UDim2.new(0, 200, 0, 50)
		          end
						end
					end
				end
			end
		end
		wait(0.01)
	end
	if getgenv().PlayerESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player and player:FindFirstChild("LuzESP") then
				if player.LuzESP.Enabled == true then
					player.LuzESP.Enabled = false
				end
			end
			if players and player and player:FindFirstChild("Head") and player.Head:FindFirstChild("NameESP") then
				player.Head.NameESP:Destroy()
			end
		end
	end
end
local function ChestsESP()
	while getgenv().ChestsESP == true do
		for _, chest in pairs(workspace.Chest:GetChildren()) do
			if chest:IsA("Model") then
				for numero = 1, 2 do
					local finei = "Chest" .. numero .. "base1"
					if chest:FindFirstChild(finei) then
						if chest:FindFirstChild("LuzESP") then
							if chest.LuzESP.Enabled == false then
								chest.LuzESP.Enabled = true
							end
						else
							local highlight = Instance.new("Highlight")
							highlight.Name = "LuzESP"
							highlight.FillColor = Color3.fromRGB(30, 255, 0)
							highlight.OutlineColor = Color3.fromRGB(255, 125, 0)
							highlight.FillTransparency = 0.6
							highlight.Adornee = chest
							highlight.Parent = chest
						end
						if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
							local pau = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - chest[finei].Position).Magnitude)
							local distance = chest.Name .. " [" .. pau .. " Studs]"
							if chest:FindFirstChild("NameESP") then
								if chest.NameESP.TextESP.Text ~= distance then
									chest.NameESP.TextESP.Text = distance
								end
							else
								local bgui = Instance.new("BillboardGui", chest)
								bgui.Name = "NameESP"
								bgui.AlwaysOnTop = true
								bgui.ExtentsOffset = Vector3.new(0, 0.6, 0)
								bgui.Size = UDim2.new(0, 200, 0, 50)
								bgui.MaxDistance = 1500
								if not chest.NameESP:FindFirstChild("TextESP") then
									local nam = Instance.new("TextLabel", bgui)
									nam.Name = "TextESP"
									nam.Text = distance
									nam.BackgroundTransparency = 1
									nam.TextSize = 15
									nam.Font = Enum.Font.GothamBold
									nam.TextColor3 = Color3.fromRGB(30, 255, 0)
									nam.Size = UDim2.new(0, 200, 0, 50)
								end
							end
						end
					end
				end
			end
		end
		wait(0.1)
	end
	if getgenv().ChestsESP == false then
		for _, chest in pairs(workspace.Chest:GetChildren()) do
			if chest:IsA("Model") then
				if chest:FindFirstChild("LuzESP") then
					if chest.LuzESP.Enabled == true then
						chest.LuzESP.Enabled = false
					end
				end
				if chest:FindFirstChild("NameESP") then
					chest.NameESP:Destroy()
				end
			end
		end
	end
end
local function Fullbright()
    while getgenv().Fullbright == true do
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        wait(0.01)
    end
    game:GetService("Lighting").Brightness = 1
    game:GetService("Lighting").ClockTime = 14
    game:GetService("Lighting").FogEnd = 10000000
    game:GetService("Lighting").GlobalShadows = true
    game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(200, 200, 200)
end
local function NoFog()
	local Lighting = game:GetService("Lighting")
	Lighting.FogEnd = 100000
	Lighting:GetPropertyChangedSignal("FogEnd"):Connect(function()
		Lighting.FogEnd = 100000
   end)
	for _,v in ipairs(Lighting:GetDescendants()) do
		if v:IsA("Atmosphere") then
 			v.Density = 0
	 		v:GetPropertyChangedSignal("Density"):Connect(function()
 			v.Density = 0
			end)
		end
	end
			Lighting.DescendantAdded:Connect(function(v)
    	if v:IsA("Atmosphere") then
        		v.Density = 0
					v:GetPropertyChangedSignal("Density"):Connect(function()
				v.Density = 0
      end)
		end
	end)
end
-- workspace.Monsters.monster0101.MonsterTitle.DescLabel
local function AutoMobs()
	while getgenv().AutoMobs == true do
		for _, mob in pairs(workspace.Monsters:GetChildren()) do
			if mob.Name == SelectedMob then
				if mob:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.HumanoidRootPart then
					if not mob:FindFirstChild("pussy") then
						local weld = Instance.new("Weld")
						weld.Name = "pussy"
						weld.Part0 = mob.HumanoidRootPart
						weld.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart
						weld.C0 = CFrame.new(0, 9, 0)
						weld.Parent = mob
					end
				end
			end
		end
		wait(0.33)
	end
	if getgenv().AutoMobs == false then
		for _, mob in pairs(workspace.Monsters:GetChildren()) do
			if mob:FindFirstChild("pussy") then
				mob.pussy:Destroy()
			end
		end
	end
end
-- it's working but it's adding the weld in every mob, it needs to do it with only one mob per time

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Dropdown = Menu:CreateDropdown({
   Name = "Select Mob to Farm",
   Options = {"Pirate [Lv:1]"},
   CurrentOption = {"No Mob Selected"},
   MultipleOptions = false,
   Callback = function(Options)
   	SelectedMob = Options[1]
   	if SelectedMob == "Pirate [Lv:1]" then
   		SelectedMob = "monster0101"
   	end
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Auto Farm Mobs",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoMobs = Value
   	AutoMobs()
   end,
})
local Section = Menu:CreateSection("Chest Farm")
local Toggle = Menu:CreateToggle({
   Name = "Auto Farm Chests (In Island)",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoChest = Value
   	AutoChest()
   end,
})

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
local Toggle =  VisualTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Fullbright = Value
   	Fullbright()
   end,
})
local Button = VisualTab:CreateButton({
   Name = "No Fog",
   Callback = function()
   	NoFog()
   end,
})
local Section = VisualTab:CreateSection("ESP")
local Toggle =  VisualTab:CreateToggle({
   Name = "ESP Players",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PlayerESP = Value
   	PlayerESP()
   end,
})
local Toggle =  VisualTab:CreateToggle({
   Name = "ESP Chests",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().ChestsESP = Value
   	ChestsESP()
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

-- Credits
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Creator")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
local Button = Credits:CreateButton({
   Name = "Copy Server Link",
   Callback = function()
   	setclipboard("discord.gg/AESCuek87s")
   	toclipboard("discord.gg/AESCuek87s")
    end,
})
local Section = Credits:CreateSection("Note")
local Label = Credits:CreateLabel("If you find any bug join the discord and open a ticket")