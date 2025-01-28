local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Murderers VS Sheriffs Duels",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst",
   
   ConfigurationSaving = {
   Enabled = true,
   FolderName = "🎃 Hallow Hub",
   FileName = "MVSD"
   }
})

-- Valores
getgenv().HitBox = false
getgenv().Triggerbot = false
getgenv().NameESP = false
getgenv().OutlineESP = false
getgenv().AutoKill = false
getgenv().AutoGun = false
getgenv().AutoQueue = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local SelectedQueue = "Nenhum"
local InCooldown = false
local HitSize = 9

-- Funções
local function Triggerbot()
  local Players = game:GetService("Players")
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local CurrentCamera = workspace.CurrentCamera
  local function SetCooldown()
    if not InCooldown then
      InCooldown = true
      task.wait(3)
      InCooldown = false
    end
  end
  local function RayOn(part)
    local origin = CurrentCamera.CFrame.Position
    local direction = (part.Position - origin).Unit * 1000
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {eu.Character:GetChildren()}
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    local result = workspace:Raycast(origin, direction, rayParams)
    return result and result.Instance and result.Instance.Parent == part.Parent
    end
  local function GetToolPosition(tool)
    for _, child in pairs(tool:GetChildren()) do
      if child:IsA("BasePart") then
        return child.Position
      end
    end
    return nil
  end
  while getgenv().Triggerbot and not InCooldown do
    pcall(function()
      for _, player in pairs(Players:GetPlayers()) do
        if player ~= eu and player:GetAttribute("Match") == eu:GetAttribute("Match") and player.Team ~= eu.Team and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health >= 1 then
          if RayOn(player.Character.LowerTorso) then
            for _, tool in pairs(eu.Character:GetChildren()) do
              if tool:IsA("Tool") and tool:FindFirstChild("Fire") then
                local toolPosition = GetToolPosition(tool)
                if toolPosition and not InCooldown then
                  ReplicatedStorage.Remotes.Shoot:FireServer(
                    player.Character.HumanoidRootPart.Position,
                    toolPosition,
                    player.Character.Head,
                    toolPosition
                  )
                  SetCooldown()
                  break
                end
              end
            end
          end
        end
      end
      if not getgenv().HitBox then
        for _, player in pairs(Players:GetPlayers()) do
          if player ~= eu and player:GetAttribute("Match") == eu:GetAttribute("Match") and player.Team ~= eu.Team and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health >= 1 then
            local partSize = player.Character.HumanoidRootPart.Size
            if partSize.X < 2 or partSize.Y < 2 or partSize.Z < 2 then
              player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 2)
            end
          end
        end
      end
    end)
    wait(0.1)
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
  pcall(function()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
      if player and player.Character and player:GetAttribute("Match") == eu:GetAttribute("Match") and player.Team ~= eu.Team then
        game:GetService("ReplicatedStorage").Remotes.Shoot:FireServer(player.Character.HumanoidRootPart.Position, player.Character.HumanoidRootPart.Position, player.Character.Head, player.Character.HumanoidRootPart.Position)
      end
    end
  end)
end
local function AutoKill()
  while getgenv().AutoKill do
    pcall(function()
      KillAll()
    end)
    wait(0.1)
  end
end
local function AutoGun()
  while getgenv().AutoGun == true do
    for _, tool in pairs(eu.Backpack:GetChildren()) do
      if tool:IsA("Tool") and tool:FindFirstChild("Fire") then
        tool.Parent = eu.Character
      end
    end
    wait()
  end
end
local function AutoQueue()
  while getgenv().AutoQueue do
    if SelectedQueue == "1v1" then
      game:GetService("ReplicatedStorage").GlobalMatchmaking.Remotes.JoinQueue:InvokeServer("Solo")
    elseif SelectedQueue == "2v2" then
      game:GetService("ReplicatedStorage").GlobalMatchmaking.Remotes.JoinQueue:InvokeServer("Duo")
    elseif SelectedQueue == "3v3" then
      game:GetService("ReplicatedStorage").GlobalMatchmaking.Remotes.JoinQueue:InvokeServer("Trio")
    elseif SelectedQueue == "4v4" then
      game:GetService("ReplicatedStorage").GlobalMatchmaking.Remotes.JoinQueue:InvokeServer("Squad")
    else
      Rayfield:Notify({
		   Title = "No Type Selected!",
		   Content = "You need to select it before you turn it on!",
		   Duration = 3,
		   Image = 17091459839,
      })
    end
    wait(3)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
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
   Flag = "AutoKillToggle",
   Callback = function(Value)
   	getgenv().AutoKill = Value
   	AutoKill()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Equip Gun",
   CurrentValue = false,
   Flag = "AutoGunToggle",
   Callback = function(Value)
   	getgenv().AutoGun = Value
   	AutoGun()
   end,
})
Section = Menu:CreateSection("Aim Assistant")
Toggle =  Menu:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Flag = "TriggerbotToggle",
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
    if tonumber(Text) < 2 then
      Rayfield:Notify({
		   Title = "Bigger!",
		   Content = "The hitbox value needs to be atleast 2.",
		   Duration = 2.6,
		   Image = 17091459839,
      })
   	else
   	  HitSize = tonumber(Text)
   	end
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Expand Hitboxes",
   CurrentValue = false,
   Flag = "HitBoxToggle",
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
   Flag = "OutlineToggle",
   Callback = function(Value)
   	getgenv().OutlineESP = Value
   	OutlineESP()
   end,
})
Toggle =  VisualTab:CreateToggle({
   Name = "Name ESP",
   CurrentValue = false,
   Flag = "NameToggle",
   Callback = function(Value)
   	getgenv().NameESP = Value
   	NameESP()
   end,
})

-- Queue
local QueueTab = Window:CreateTab("Queue", "circle-ellipsis")
Section = QueueTab:CreateSection("Auto Farm")
Dropdown = QueueTab:CreateDropdown({
   Name = "Queue Type",
   Options = {"1v1", "2v2", "3v3", "4v4"},
   CurrentOption = {"No Type Selected"},
   MultipleOptions = false,
   Flag = "QueueDropdown",
   Callback = function(Options)
   		SelectedQueue = Options[1]
   end,
})
Toggle =  QueueTab:CreateToggle({
   Name = "Auto Queue",
   CurrentValue = false,
   Flag = "QueueToggle",
   Callback = function(Value)
   	getgenv().AutoQueue = Value
   	AutoQueue()
   end,
})
Paragraph = QueueTab:CreateParagraph({
  Title = "Guide to Use",
  Content = "Turn on all the toggles in the Main tab before Auto Queue if you want to AFK farm (not 100%)"
})