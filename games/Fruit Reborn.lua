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
getgenv().BringMobs = false
getgenv().RenewQuests = false

-- Locais
local IlhaSelecionada = "Nenhum"
local ModoDeBaus = "Nenhum"

-- Funções
local function RenewQuests()
  while getgenv().RenewQuests == true do
    game:GetService("Players").LocalPlayer:SetAttribute("AutoQuest", 1)
    wait(0.01)
  end
  if getgenv().RenewQuests == false then
    game:GetService("Players").LocalPlayer:SetAttribute("AutoQuest", 1)
  end
end
local function AutoChest()
  if ModoDeBaus == "Nenhum" then
    Rayfield:Notify({
      Title = "No Chest Mode Selected!",
      Content = "You have to select it before you farm.",
      Duration = 5,
      Image = 17091459839,
    })
  end
	while getgenv().AutoChest == true do
	  pcall(function()
  	  if ModoDeBaus == "Closers Chests" then
    		for _, chest in pairs(workspace.Chest:GetChildren()) do
    			if chest:IsA("Model") then
    				for numero = 1, 2 do
    					local final = "Chest" .. numero .. "base1"
    					if chest:FindFirstChild(final) and workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
    						game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("Hallow_Hub", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
    						if getgenv().AutoChest == true then
    							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chest[final].CFrame
    							wait(0.7)
    							for _, pp in pairs(chest:GetDescendants()) do
    								if pp:IsA("ProximityPrompt") then
    									fireproximityprompt(pp)
    									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("Hallow_Hub")
    								break
    								end
    							end
    						end
    					break
    					end
    				end
    			end
  			end
  			wait(0.2)
  	  elseif ModoDeBaus == "All Islands" then
  	    game.Players.LocalPlayer.Character.HumanoidRootPart:SetAttribute("Hallow_Hub", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
  	    for _, v in pairs(workspace.Chest:GetChildren()) do
  	      if getgenv().AutoChest == true and v:IsA("Model") then
  	        local wp = v.WorldPivot
  	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(wp.Position)
  	        wait(0.3)
  	        if v.ProximityPrompt then
  	          fireproximityprompt(v.ProximityPrompt)
  	          wait(0.05)
  	          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("Hallow_Hub")
  	        end
  	      end
  	    end
  	    wait(0.15)
  	  end
	  end)
	wait()
	end
	wait(1)
	if getgenv().AutoChest == false then
		pcall(function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart:GetAttribute("Hallow_Hub")
		end)
	end
end
local function BringMobs()
  local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
  while getgenv().BringMobs == true do
    for _, mob in pairs(workspace.Monsters:GetChildren()) do
      if getgenv().BringMobs == true and mob:IsA("Model") and mob:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
        mob.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -9)
      end
    end
    wait(1)
  end
end
local function AutoBaus()
  while getgenv().AutoBaus == true do
    for _, v in pairs(workspace.Chest:GetChildren()) do
      if getgenv().AutoBaus == true and v:IsA("Model") then
        local wp = v.WorldPivot
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(wp.Position)
        wait(0.3)
        if v.ProximityPrompt then
          fireproximityprompt(v.ProximityPrompt)
          break
        end
      end
    end
    wait(0.2)
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
local function IlhaTP()
	if IlhaSelecionada == "[Lv. 1] Center Town" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4679.76367, 42.2578659, 456.411102, -0.0171580166, 7.95514978e-08, 0.999852777, 2.43265301e-08, 1, -7.91457566e-08, -0.999852777, 2.2964965e-08, -0.0171580166)
	elseif IlhaSelecionada == "[Lv. 100] Arena Island" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2824.09326, 39.8518562, 497.499268, 0.0509811006, -4.10657748e-08, -0.998699605, -3.91588486e-08, 1, -4.31182059e-08, 0.998699605, 4.13061407e-08, 0.0509811006)
	elseif IlhaSelecionada == "[Lv. 400] Pirate Port" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2593.84937, 37.4718246, 2821.4707, 0.939572215, 1.30868498e-08, -0.342350781, -3.92323507e-09, 1, 2.7459226e-08, 0.342350781, -2.44568028e-08, 0.939572215)
	elseif IlhaSelecionada == "[Lv. 600] Demon Island" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2926.09741, 35.8855057, -2311.03296, 0.999669671, 1.29144775e-08, -0.0257012546, -1.08754765e-08, 1, 7.94744466e-08, 0.0257012546, -7.91686787e-08, 0.999669671)
	elseif IlhaSelecionada == "[Lv. 800] Ninja Village" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(549.231873, 19.581461, -1566.31616, -0.515836358, -2.40943194e-08, 0.856687129, 3.22156133e-08, 1, 4.75229562e-08, -0.856687129, 5.2112771e-08, -0.515836358)
	elseif IlhaSelecionada == "[Lv. 1000] Namek Planet" then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(27.1166286, 19.2115784, 2631.10156, 0.450213253, -0.0156807061, 0.892783344, 0.00335402554, 0.999868453, 0.0158701614, -0.892914772, -0.00415053824, 0.450206608)
	else
		Rayfield:Notify({
			Title = "No Island selected.",
			Content = "You have to select it before you teleport.",
			Duration = 3,
			Image = 17091459839,
		})
	end
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Mob Farm")
local Toggle = Menu:CreateToggle({
   Name = "Auto Renew Quest",
   CurrentValue = false,
   Callback = function(Value)
    getgenv().RenewQuests = Value
    RenewQuests()
   end,
})
local Section = Menu:CreateSection("Chest Farm")
local Dropdown = Menu:CreateDropdown({
   Name = "Auto Chests Mode",
   Options = {"Closers Chests", "All Islands"},
   CurrentOption = {"Select the Mode"},
   MultipleOptions = false,
   Callback = function(Options)
   		ModoDeBaus = Options[1]
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Auto Farm Chests",
   CurrentValue = false,
   Callback = function(Value)
    getgenv().AutoChest = Value
    AutoChest()
   end,
})
local Section = Menu:CreateSection("More features coming soon...")
local Label = Menu:CreateLabel("Join our discord in the credits tab!")

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
local Section = VisualTab:CreateSection("More features coming soon...")
local Label = VisualTab:CreateLabel("Join our discord in the credits tab!")

-- Teleport
local TPsTab = Window:CreateTab("Teleport", "Shell")
local Section = TPsTab:CreateSection("Teleport to Island")
local Dropdown = TPsTab:CreateDropdown({
   Name = "Selected Island",
   Options = {"[Lv. 1] Center Town", "[Lv. 100] Arena Island", "[Lv. 400] Pirate Port", "[Lv. 600] Demon Island", "[Lv. 800] Ninja Village", "[Lv. 1000] Namek Planet"},
   CurrentOption = {"No Island Selected"},
   MultipleOptions = false,
   Callback = function(Options)
   		IlhaSelecionada = Options[1]
   end,
})
local Button = TPsTab:CreateButton({
   Name = "Teleport to Island",
   Callback = function()
       IlhaTP()
    end,
})
local Section = TPsTab:CreateSection("More features coming soon...")
local Label = TPsTab:CreateLabel("Join our discord in the credits tab!")

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

local ServersTab = Window:CreateTab("Server", "compass")
local ServerSection = ServersTab:CreateSection("Server Actions", true)

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local PlaceId = game.PlaceId  
local JobId = game.JobId 

-- Rejoin button
ServersTab:CreateButton({
    Name = "Rejoin Game",
    Callback = function()
        if #Players:GetPlayers() <= 1 then
            Players.LocalPlayer:Kick("\nRejoining...")
            wait(1) 
            TeleportService:Teleport(PlaceId, Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
        end
    end,
})
                                                                                                    --end rejoin
                                                                                                    --serverhop

local PlaceId, JobId = game.PlaceId, game.JobId

local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function serverHop()
    if httprequest then
        local servers = {}
        local req = httprequest({
            Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId),
            Method = "GET"
        })

        local body = HttpService:JSONDecode(req.Body)

        if body and body.data then
            for _, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            local serverToJoin = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(PlaceId, serverToJoin, Players.LocalPlayer)
        else
            Rayfield:Notify({
                Title = "Serverhop",
                Content = "Couldn't find a server.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("The user tapped Okay!")
                        end
                    },
                },
            })
        end
    else
        local servers = {}
        local success, req = pcall(function()
            return HttpService:GetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId))
        end)

        if success and req then
            local body = HttpService:JSONDecode(req)
            if body and body.data then
                for _, v in next, body.data do
                    if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                        table.insert(servers, 1, v.id)
                    end
                end
            end

            if #servers > 0 then
                local serverToJoin = servers[math.random(1, #servers)]
                TeleportService:TeleportToPlaceInstance(PlaceId, serverToJoin, Players.LocalPlayer)
            else
                Rayfield:Notify({
                    Title = "Serverhop",
                    Content = "Couldn't find a server.",
                    Duration = 6.5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("The user tapped Okay!")
                            end
                        },
                    },
                })
            end
        else
            Rayfield:Notify({
                Title = "Incompatible Exploit",
                Content = "Your exploit does not support HTTP requests.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("The user tapped Okay!")
                        end
                    },
                },
            })
        end
    end
end

ServersTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        serverHop()
    end,
})


local Section = MoveTab:CreateSection("More features coming soon...")
local Label = MoveTab:CreateLabel("Join our discord in the credits tab!")
