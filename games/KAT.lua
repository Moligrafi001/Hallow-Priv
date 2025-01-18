-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/KAT.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | KAT",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Movement
local WalkSpeedText = 16
getgenv().SetWalkSpeed = false
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
getgenv().OutlineESP = false
getgenv().NameESP = false
getgenv().InvisKnf = false

-- Funções
local function OutlineESP()
	while getgenv().OutlineESP == true do
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player then
				if player ~= game.Players.LocalPlayer.Character then
					if player:FindFirstChild("LuzESP") and getgenv().OutlineESP == true then
						if player.LuzESP.Enabled == false then
							player.LuzESP.Enabled = true
						end
						if workspace.Gamemode.Value == "Murder" then
							if players.Backpack:FindFirstChild("Knife") or player:FindFirstChild("Knife") then
								if player.LuzESP.FillColor ~= Color3.fromRGB(255, 0, 0) or player.LuzESP.OutlineColor ~= Color3.fromRGB(255, 0, 0) then
									player.LuzESP.FillColor = Color3.fromRGB(255, 0, 0)
									player.LuzESP.OutlineColor = Color3.fromRGB(255, 0, 0)
								end
							elseif players.Backpack:FindFirstChild("Revolver") or player:FindFirstChild("Revolver") then
								if player.LuzESP.FillColor ~= Color3.fromRGB(0, 30, 255) or player.LuzESP.OutlineColor ~= Color3.fromRGB(0, 30, 255) then
									player.LuzESP.FillColor = Color3.fromRGB(0, 30, 255)
									player.LuzESP.OutlineColor = Color3.fromRGB(0, 30, 255)
								end
							end
						elseif workspace.Gamemode.Value == "Classic" then
							if player.LuzESP.FillColor ~= Color3.fromRGB(255, 125, 0) or player.LuzESP.OutlineColor ~= Color3.fromRGB(0, 125, 0) then
								player.LuzESP.FillColor = Color3.fromRGB(255, 125, 0)
								player.LuzESP.OutlineColor = Color3.fromRGB(255, 125, 0)
							end
						end
					elseif not player:FindFirstChild("LuzESP") and getgenv().OutlineESP == true then
						local highlight = Instance.new("Highlight")
						highlight.Name = "LuzESP"
						highlight.FillColor = Color3.fromRGB(255, 125, 0)
						highlight.OutlineColor = Color3.fromRGB(255, 125, 0)
						highlight.FillTransparency = 0.6
						highlight.Adornee = player
						highlight.Parent = player
					end
				end
			end
		end
		wait(0.01)
	end
	if getgenv().OutlineESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player and player:FindFirstChild("LuzESP") then
				if player.LuzESP.Enabled == true then
					player.LuzESP.Enabled = false
				end
			end
		end
	end
end
local function NameESP()
	while getgenv().NameESP == true do
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player then
				if player ~= game.Players.LocalPlayer.Character then
					if getgenv().NameESP == true and player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Head") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local distance = player.Name .. " [" .. math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.HumanoidRootPart.Position).Magnitude) .. " Studs]"
						if player.Head:FindFirstChild("NameESP") then
							if player.Head.NameESP.TextESP.Text ~= distance then
								player.Head.NameESP.TextESP.Text = distance
							end
							if workspace.Gamemode.Value == "Murder" then
								if players.Backpack:FindFirstChild("Knife") or player:FindFirstChild("Knife") then
									if player.Head.NameESP.TextESP.TextColor3 ~= Color3.fromRGB(255, 0, 0) then
										player.Head.NameESP.TextESP.TextColor3 = Color3.fromRGB(255, 0, 0)
									end
								elseif players.Backpack:FindFirstChild("Revolver") or player:FindFirstChild("Revolver") then
									if player.Head.NameESP.TextESP.TextColor3 ~= Color3.fromRGB(0, 30, 255) then
										player.Head.NameESP.TextESP.TextColor3 = Color3.fromRGB(0, 30, 255)
									end
								end
							elseif workspace.Gamemode.Value == "Classic" then
								if player.Head.NameESP.TextESP.TextColor3 ~= Color3.fromRGB(255, 125, 0) then
									player.Head.NameESP.TextESP.TextColor3 = Color3.fromRGB(255, 125, 0)
								end
							end
						else
							local bgui = Instance.new("BillboardGui", player.Head)
	            bgui.Name = "NameESP"
	            bgui.AlwaysOnTop = true
	            bgui.ExtentsOffset = Vector3.new(0, 3, 0)
	            bgui.Size = UDim2.new(0, 200, 0, 50)
	            bgui.MaxDistance = 999
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
	if getgenv().NameESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player and player:FindFirstChild("Head") and player.Head:FindFirstChild("NameESP") then
				player.Head.NameESP:Destroy()
			end
		end
	end
end
local function InvisKnf()
	while getgenv().InvisKnf == true do
		pcall(function()
			for _, player in pairs(game.Players:GetPlayers()) do
				if player == game.Players.LocalPlayer then
					local corpo = player.Character
					if player and corpo then
						if corpo:FindFirstChild("WeaponsGiven") then
							if corpo.WeaponsGiven.Value == true then
								for _, tool in pairs(corpo:GetChildren()) do
									if tool:IsA("Tool") then
										if tool.ToolType.Value == "Knife" then
											game:GetService("Players").LocalPlayer.Character.Knife.ClientEvent:FireServer("SetVisible", {false})
										end
									end
								end
							end
						end
					end
				end
			end
		end)
		wait(0.01)
	end
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Misc")
local Toggle =  Menu:CreateToggle({
   Name = "Invisible Knife",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().InvisKnf = Value
   	InvisKnf()
   end,
})

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
local Section = VisualTab:CreateSection("Player ESP")
local Toggle =  VisualTab:CreateToggle({
   Name = "Outline ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().OutlineESP = Value
   	OutlineESP()
   end,
})
local Toggle =  VisualTab:CreateToggle({
   Name = "Name ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().NameESP = Value
   	NameESP()
   end,
})

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
local Section = MoveTab:CreateSection("Walk")
local Slider = MoveTab:CreateSlider({
   Name = "Player Walk Speed",
   Range = {0, 30},
   Increment = 1,
   Suffix = "",
   CurrentValue = 16,
   Callback = function(Value)
   	WalkSpeedText = Value
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