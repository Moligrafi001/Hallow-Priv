local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Murderers VS Sheriffs Duels",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().HitBox = false
getgenv().Triggerbot = false
getgenv().NameESP = false
getgenv().OutlineESP = false
getgenv().AutoKill = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local InCooldown = false
local HitSize = 9

-- Funções
local function Triggerbot()
  local Players = game:GetService("Players")
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local CurrentCamera = workspace.CurrentCamera
  local InCooldown = false
  local function SetCooldown()
    if not InCooldown then
      InCooldown = true
      task.wait(2.5)
      InCooldown = false
    end
  end
  local function RayOn(part)
    local origin = CurrentCamera.CFrame.Position
    local direction = (part.Position - origin).Unit * 1000
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
  
    local result = workspace:Raycast(origin, direction, rayParams)
    if result and result.Instance and result.Instance.Parent == part.Parent then
      return true
    end
    return false
  end
  while getgenv().Triggerbot and not InCooldown do
    for _, player in pairs(Players:GetPlayers()) do
      if player ~= eu and player:GetAttribute("Match") == eu:GetAttribute("Match") and 
         player.Team ~= eu.Team and player.Character and 
         player.Character:FindFirstChild("Humanoid") and 
         player.Character.Humanoid.Health >= 1 then

        if not InCooldown and RayOn(player.Character.Head) then
          ReplicatedStorage.Remotes.Shoot:FireServer(
            Vector3.new(-117.687, 179.375, -29.734), 
            Vector3.new(-108.699, 171.277, -33.298), 
            player.Character.Head,
            Vector3.new(-113.910, 178.863, -29.015)
          )
          SetCooldown()
        end
      end
    end
    wait()
  end
end
local function OutlineESP()
	while getgenv().OutlineESP == true do
	  pcall(function()
  		for _, players in pairs(game.Players:GetPlayers()) do
  			local player = players.Character
  			if players and player then
  				if player ~= game.Players.LocalPlayer.Character and players:GetAttribute("Match") == eu:GetAttribute("Match") and players.Team ~= eu.Team then
  					if player:FindFirstChild("LuzESP") and getgenv().OutlineESP == true then
  						if player.LuzESP.Enabled == false then
  							player.LuzESP.Enabled = true
  						end
  						if player.Humanoid and player.Humanoid.Health <= 0 then
  				      player.LuzESP:Destroy()
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
		end)
		wait(0.01)
	end
	if getgenv().OutlineESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if players and player and player:FindFirstChild("LuzESP") and players:GetAttribute("Match") == eu:GetAttribute("Match") and players.Team ~= eu.Team then
				if player.LuzESP.Enabled == true then
					player.LuzESP.Enabled = false
				end
			end
		end
	end
end
local function NameESP()
	while getgenv().NameESP == true do
	  pcall(function()
  		for _, players in pairs(game.Players:GetPlayers()) do
  			local player = players.Character
  			if players and player then
  				if player ~= game.Players.LocalPlayer.Character and players:GetAttribute("Match") == eu:GetAttribute("Match") and players.Team ~= eu.Team then
  					if getgenv().NameESP == true and player:FindFirstChild("HumanoidRootPart") and player:FindFirstChild("Head") and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
		end)
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
local function HitBox()
	while getgenv().HitBox == true do
	  pcall(function()
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= eu and player:GetAttribute("Match") == eu:GetAttribute("Match") and player.Team ~= eu.Team then
				if player.Character then
				  if player.Character.Humanoid.Health <= 0 then
				    player.Character:Destroy()
				  end
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
local function KillAll()
  for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player and player.Character and player:GetAttribute("Match") == eu:GetAttribute("Match") and player.Team ~= eu.Team then
      game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(player.Character.HumanoidRootPart.Position, player.Character.HumanoidRootPart.Position, player.Character.Head, player.Character.HumanoidRootPart.Position)
    end
  end
end
local function AutoKill()
  while getgenv().AutoKill do
    pcall(function()
      KillAll()
    end)
    wait(0.1)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Blatant")
Toggle =  Menu:CreateButton({
   Name = "Kill All",
   CurrentValue = false,
   Callback = function()
   	KillAll()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Kill All",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoKill = Value
   	AutoKill()
   end,
})
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

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
Section = VisualTab:CreateSection("Player ESP")
Toggle =  VisualTab:CreateToggle({
   Name = "Outline ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().OutlineESP = Value
   	OutlineESP()
   end,
})
Toggle =  VisualTab:CreateToggle({
   Name = "Name ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().NameESP = Value
   	NameESP()
   end,
})

-- workspace.TheMoneyBeaster.Default.Fire
local args = {
    [1] = Vector3.new(278.50396728515625, 60.77000427246094, -56.05403518676758),
    [2] = Vector3.new(255.29518127441406, 64.43893432617188, 75.72250366210938),
    [3] = workspace.House.Walls.MajorWall,
    [4] = Vector3.new(257.0283203125, 64.28755950927734, 65.875)
}

-- game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(unpack(args))