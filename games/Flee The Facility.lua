-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Flee%20The%20Facility.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Flee The Facility",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
_G.Fullbright = false
_G.AntiPcError = false
_G.AutoInteract = false
_G.SpyExecuted = false

local invisRunning = false
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")


-- ESP
_G.PlayerESP = false
local CorInocente = Color3.fromRGB(255, 125, 0)
local CorBesta = Color3.fromRGB(255, 0, 0)
local function PlayerESP()
	while _G.PlayerESP == true do
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if player then
				if player.Name ~= game.Players.LocalPlayer.Name then
					if player:FindFirstChild("BeastPowers") then
						if player:FindFirstChild("Highlight") then
							if player.Highlight.FillColor or player.Highlight.OutlineColor ~= CorBesta then
								player.Highlight.FillColor = CorBesta
								player.Highlight.OutlineColor = CorBesta
							end
						else
							local highlight = Instance.new("Highlight")
							highlight.FillColor = CorBesta
							highlight.OutlineColor = CorBesta
							highlight.FillTransparency = 0.6
							highlight.Adornee = player
							highlight.Parent = player
						end
					else
						if player:FindFirstChild("Highlight") then
							if player.Highlight.FillColor or player.Highlight.OutlineColor ~= CorInocente then
								player.Highlight.FillColor = CorInocente
								player.Highlight.OutlineColor = CorInocente
							end
						else
							local highlight = Instance.new("Highlight")
							highlight.FillColor = CorInocente
							highlight.OutlineColor = CorInocente
							highlight.FillTransparency = 0.6
							highlight.Adornee = player
							highlight.Parent = player
						end
					end
					if player:FindFirstChild("Highlight") then
						if player.Highlight.Enabled == false then
							player.Highlight.Enabled = true
						end
					end
				end
			end
		end
		wait(0.33)
	end
	if _G.PlayerESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if player then
				if player.Name ~= game.Players.LocalPlayer.Name then
					if player:FindFirstChild("Highlight") then
						if player.Highlight.Enabled == true then
							player.Highlight.Enabled = false
						end
					end
				end
			end
		end
	end
end
--
_G.ComputerESP = false
local function ComputerESP()
	while _G.ComputerESP == true do
		for _, map in pairs(workspace:GetChildren()) do
			for _, computer in pairs(map:GetChildren()) do
				if computer.Name == "ComputerTable" then
					if computer:FindFirstChild("Screen") then
						if computer:FindFirstChild("Highlight") then
							if computer.Highlight.FillColor ~= computer.Screen.Color or computer.Highlight.OutlineColor ~= computer.Screen.Color then
								computer.Highlight.FillColor = computer.Screen.Color
								computer.Highlight.OutlineColor = computer.Screen.Color
							elseif computer.Highlight.Enabled == false then
								computer.Highlight.Enabled = true
							end
						else
							local highlight = Instance.new("Highlight")
							highlight.FillColor = computer.Screen.Color
							highlight.OutlineColor = computer.Screen.Color
							highlight.FillTransparency = 1
							highlight.Adornee = computer
							highlight.Parent = computer
						end
					end
				end
			end
		end
		wait(0.33)
	end
	if _G.ComputerESP == false then
		for _, map in pairs(workspace:GetChildren()) do
			for _, computer in pairs(map:GetChildren()) do
				if computer.Name == "ComputerTable" then
					if computer:FindFirstChild("Highlight") then
						if computer.Highlight.Enabled == true then
							computer.Highlight.Enabled = false
						end
					end
				end
			end
		end
	end
end
--
_G.FreezeESP = false
local CorCapsula = Color3.fromRGB(85, 178, 224)
local function FreezeESP()
	while _G.FreezeESP == true do
		for _, map in pairs(workspace:GetChildren()) do
			for _, pod in pairs(map:GetChildren()) do
				if pod.Name == "FreezePod" then
					if pod:FindFirstChild("Highlight") then
						if pod.Highlight.FillColor ~= CorCapsula or pod.Highlight.OutlineColor ~= CorCapsula then
							pod.Highlight.FillColor = CorCapsula
							pod.Highlight.OutlineColor = CorCapsula
						elseif pod.Highlight.Enabled == false then
							pod.Highlight.Enabled = true
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.FillColor = CorCapsula
						highlight.OutlineColor = CorCapsula
						highlight.FillTransparency = 0.6
						highlight.Adornee = pod
						highlight.Parent = pod
					end
				end
			end
		end
		wait(0.33)
	end
	if _G.FreezeESP == false then
		for _, map in pairs(workspace:GetChildren()) do
			for _, pod in pairs(map:GetChildren()) do
				if pod.Name == "FreezePod" then
					if pod:FindFirstChild("Highlight") then
						if pod.Highlight.Enabled == true then
							pod.Highlight.Enabled = false
						end
					end
				end
			end
		end
	end
end
--
_G.ExitESP = false
local CorSaida = Color3.fromRGB(208, 255, 69)
local function ExitESP()
	while _G.ExitESP == true do
		for _, map in pairs(workspace:GetChildren()) do
			for _, pod in pairs(map:GetChildren()) do
				if pod.Name == "ExitDoor" then
					if pod:FindFirstChild("Highlight") then
						if pod.Highlight.FillColor ~= CorSaida or pod.Highlight.OutlineColor ~= CorSaida then
							pod.Highlight.FillColor = CorSaida
							pod.Highlight.OutlineColor = CorSaida
						elseif pod.Highlight.Enabled == false then
							pod.Highlight.Enabled = true
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.FillColor = CorSaida
						highlight.OutlineColor = CorSaida
						highlight.FillTransparency = 0.6
						highlight.Adornee = pod
						highlight.Parent = pod
					end
				end
			end
		end
		wait(0.33)
	end
	if _G.ExitESP == false then
		for _, map in pairs(workspace:GetChildren()) do
			for _, pod in pairs(map:GetChildren()) do
				if pod.Name == "ExitDoor" then
					if pod:FindFirstChild("Highlight") then
						if pod.Highlight.Enabled == true then
							pod.Highlight.Enabled = false
						end
					end
				end
			end
		end
	end
end

-- FunÃ§Ãµes
local function Fullbright()
    while _G.Fullbright == true do
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
local function AntiPcError()
	while _G.AntiPcError == true do
		game:GetService("ReplicatedStorage").RemoteEvent:FireServer("SetPlayerMinigameResult", true)
		wait(0.05)
	end
end
local function CallSpy()
	if _G.SpyExecuted == false then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/extra/ChatSpy.lua",true))()
		Rayfield:Notify({
	   Title = "Chat Spy executed!",
	   Content = "The messages will appear in orange on the chat.",
	   Duration = 5,
	   Image = 17091459839,
		})
	else
		Rayfield:Notify({
	   Title = "Only once!",
	   Content = "You already executed the Chat Spy!",
	   Duration = 4,
	   Image = 17091459839,
		})
	end
end
local function InvadeMatch()
	if game:GetService("ReplicatedStorage").IsGameActive.Value == true then
		local character = game.Players.LocalPlayer.character
		if character then
			local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
			humanoidRootPart.CFrame = CFrame.new(124.5, 25.99999857, 138.5)
			game.Workspace.CurrentCamera.CFrame = CFrame.new(124.5, 4.99999857, 138.5, -0.351053178, 0, 0.936355531, 0, 1, 0, -0.936355531, 0, -0.351053178)
		end
	else
		Rayfield:Notify({
	   Title = "It's not ready!",
	   Content = "The match didn't started yet.",
	   Duration = 3,
	   Image = 17091459839,
		})
	end
end
local function AutoInteract()
	while _G.AutoInteract == true do
		game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
		wait(0.1)
	end
end

-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
_G.SetWalkSpeed = false
_G.SetJumpPower = false
_G.InfJump = false
_G.NoClip = false
_G.NoSlow = false
local function SetWalkSpeed()
	while _G.SetWalkSpeed == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
		end
		wait(0.1)
	end
	if _G.SetWalkSpeed == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end
local function SetJumpPower()
	while _G.SetJumpPower == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower ~= JumpPowerText then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = JumpPowerText
		end
		wait(0.01)
		end
	if _G.SetJumpPower == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
	end
end
local function InfJump()
	while _G.InfJump == true do
		game:GetService("UserInputService").JumpRequest:connect(function()
			if _G.InfJump == true then
				game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
			end
		end)
		wait(0.1)
	end
end
local function NoClip()
	while _G.NoClip == true do
		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				if _G.NoClip then
					part.CanCollide = false
				else
					part.CanCollide = true
				end
			end
		end
		wait(0.1)
	end
end
local function NoSlow()
	while _G.NoSlow == true do
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed <= 16 then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
		end
		wait(0.01)
	end
end
local function findBeast()
    for _, player in ipairs(game.Players:GetPlayers()) do
        -- Check if the player is the beast using TempPlayerStatsModule
        local isBeast = player:FindFirstChild("TempPlayerStatsModule") and player.TempPlayerStatsModule:FindFirstChild("IsBeast")
        if isBeast and isBeast.Value then
            print("Beast found: " .. player.Name) 
            return player
        end
    end

    if playerData then
        for playerName, data in pairs(playerData) do
            if data.Role == "Beast" then
                local beastPlayer = game.Players:FindFirstChild(playerName)
                if beastPlayer then
                    print("Beast found in playerData: " .. beastPlayer.Name) 
                    return beastPlayer
                end
            end
        end
    end

    return nil
end

function miniFling(playerToFling)
		local a=game.Players.LocalPlayer;local b=a:GetMouse()local c={playerToFling}local d=game:GetService("Players")local e=d.LocalPlayer;local f=false;local g=function(h)local i=e.Character;local j=i and i:FindFirstChildOfClass("Humanoid")local k=j and j.RootPart;local l=h.Character;local m;local n;local o;local p;local q;if l:FindFirstChildOfClass("Humanoid")then m=l:FindFirstChildOfClass("Humanoid")end;if m and m.RootPart then n=m.RootPart end;if l:FindFirstChild("Head")then o=l.Head end;if l:FindFirstChildOfClass("Accessory")then p=l:FindFirstChildOfClass("Accessory")end;if p and p:FindFirstChild("Handle")then q=p.Handle end;if i and j and k then if k.Velocity.Magnitude<50 then getgenv().OldPos=k.CFrame end;if m and m.Sit and not f then end;if o then if o.Velocity.Magnitude>500 then fu.dialog("Player flung","Player is already flung. Fling again?",{"Fling again","No"})if fu.waitfordialog()=="No"then return fu.closedialog()end;fu.closedialog()end elseif not o and q then if q.Velocity.Magnitude>500 then fu.dialog("Player flung","Player is already flung. Fling again?",{"Fling again","No"})if fu.waitfordialog()=="No"then return fu.closedialog()end;fu.closedialog()end end;if o then workspace.CurrentCamera.CameraSubject=o elseif not o and q then workspace.CurrentCamera.CameraSubject=q elseif m and n then workspace.CurrentCamera.CameraSubject=m end;if not l:FindFirstChildWhichIsA("BasePart")then return end;local r=function(s,t,u)k.CFrame=CFrame.new(s.Position)*t*u;i:SetPrimaryPartCFrame(CFrame.new(s.Position)*t*u)k.Velocity=Vector3.new(9e7,9e7*10,9e7)k.RotVelocity=Vector3.new(9e8,9e8,9e8)end;local v=function(s)local w=2;local x=tick()local y=0;repeat if k and m then if s.Velocity.Magnitude<50 then y=y+100;r(s,CFrame.new(0,1.5,0)+m.MoveDirection*s.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(y),0,0))task.wait()r(s,CFrame.new(0,-1.5,0)+m.MoveDirection*s.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(y),0,0))task.wait()r(s,CFrame.new(2.25,1.5,-2.25)+m.MoveDirection*s.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(y),0,0))task.wait()r(s,CFrame.new(-2.25,-1.5,2.25)+m.MoveDirection*s.Velocity.Magnitude/1.25,CFrame.Angles(math.rad(y),0,0))task.wait()r(s,CFrame.new(0,1.5,0)+m.MoveDirection,CFrame.Angles(math.rad(y),0,0))task.wait()r(s,CFrame.new(0,-1.5,0)+m.MoveDirection,CFrame.Angles(math.rad(y),0,0))task.wait()else r(s,CFrame.new(0,1.5,m.WalkSpeed),CFrame.Angles(math.rad(90),0,0))task.wait()r(s,CFrame.new(0,-1.5,-m.WalkSpeed),CFrame.Angles(0,0,0))task.wait()r(s,CFrame.new(0,1.5,m.WalkSpeed),CFrame.Angles(math.rad(90),0,0))task.wait()r(s,CFrame.new(0,1.5,n.Velocity.Magnitude/1.25),CFrame.Angles(math.rad(90),0,0))task.wait()r(s,CFrame.new(0,-1.5,-n.Velocity.Magnitude/1.25),CFrame.Angles(0,0,0))task.wait()r(s,CFrame.new(0,1.5,n.Velocity.Magnitude/1.25),CFrame.Angles(math.rad(90),0,0))task.wait()r(s,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(90),0,0))task.wait()r(s,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))task.wait()r(s,CFrame.new(0,-1.5,0),CFrame.Angles(math.rad(-90),0,0))task.wait()r(s,CFrame.new(0,-1.5,0),CFrame.Angles(0,0,0))task.wait()end else break end until s.Velocity.Magnitude>500 or s.Parent~=h.Character or h.Parent~=d or h.Character~=l or m.Sit or j.Health<=0 or tick()>x+w end;workspace.FallenPartsDestroyHeight=0/0;local z=Instance.new("BodyVelocity")z.Name="EpixVel"z.Parent=k;z.Velocity=Vector3.new(9e8,9e8,9e8)z.MaxForce=Vector3.new(1/0,1/0,1/0)j:SetStateEnabled(Enum.HumanoidStateType.Seated,false)if n and o then if(n.CFrame.p-o.CFrame.p).Magnitude>5 then v(o)else v(n)end elseif n and not o then v(n)elseif not n and o then v(o)elseif not n and not o and p and q then v(q)else fu.notification("Can't find a proper part of target player to fling.")end;z:Destroy()j:SetStateEnabled(Enum.HumanoidStateType.Seated,true)workspace.CurrentCamera.CameraSubject=j;repeat k.CFrame=getgenv().OldPos*CFrame.new(0,.5,0)i:SetPrimaryPartCFrame(getgenv().OldPos*CFrame.new(0,.5,0))j:ChangeState("GettingUp")table.foreach(i:GetChildren(),function(A,B)if B:IsA("BasePart")then B.Velocity,B.RotVelocity=Vector3.new(),Vector3.new()end end)task.wait()until(k.Position-getgenv().OldPos.p).Magnitude<25;workspace.FallenPartsDestroyHeight=getgenv().FPDH else fu.notification("No valid character of said target player. May have died.")end end;g(c[1])
	end

local function makeInvisible(speaker)
    if invisRunning then return end
    invisRunning = true

    local Player = speaker
    repeat wait(0.1) until Player.Character
    local Character = Player.Character
    Character.Archivable = true

    local InvisibleCharacter = Character:Clone()
    InvisibleCharacter.Parent = workspace
    InvisibleCharacter.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame


    for _, part in pairs(InvisibleCharacter:GetDescendants()) do
        if part:IsA("BasePart") then
            if part.Name == "HumanoidRootPart" then
                part.Transparency = 1
            else
                part.Transparency = 0.5 
            end
            part.CanCollide = true 
        end
    end

    Player.Character = InvisibleCharacter
    Character.Parent = Lighting

    -- Camera adjustment
    workspace.CurrentCamera.CameraSubject = InvisibleCharacter:FindFirstChild("Humanoid")

    InvisibleCharacter.Animate.Disabled = true
    InvisibleCharacter.Animate.Disabled = false

end

local function makeVisible(speaker)
    if not invisRunning then return end

    local Player = speaker
    local InvisibleCharacter = Player.Character
    local OriginalCharacter = Lighting:FindFirstChild(Player.Name)

    if not OriginalCharacter then
        notify("Error", "Original character not found!")
        return
    end

    Player.Character = OriginalCharacter
    OriginalCharacter.Parent = workspace
    OriginalCharacter.HumanoidRootPart.CFrame = InvisibleCharacter.HumanoidRootPart.CFrame


    InvisibleCharacter:Destroy()

    workspace.CurrentCamera.CameraSubject = OriginalCharacter:FindFirstChild("Humanoid")


    invisRunning = false
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Helpful")
local Toggle =  Menu:CreateToggle({
   Name = "Anti PC Error",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AntiPcError = Value
   	AntiPcError()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Interact",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoInteract = Value
   end,
})
local Section = Menu:CreateSection("True Hacks")
Button = Menu:CreateButton({
    Name = "Fling Beast (May have to try multiple times)",
    Info = "Flings the Beast.", 
    Interact = 'Changable', 
    Callback = function()
        if not findBeast() then
            Rayfield:Notify({
                Title = "No Beast",
                Content = "No Beast to fling.",
                Duration = 5.0,
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
            return
        end

        miniFling(findBeast())
        
        Rayfield:Notify({
            Title = "Beast Flinged",
            Content = "The Beast has been flung!",
            Duration = 5.0,
            Image = 4483362458,
        })
    end,
})

local function notify(title, message)
    Rayfield:Notify({
        Title = title,
        Content = message,
        Duration = 6.5,
        Image = 4483362458, 
        Actions = {
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("The user tapped Okay!")
                end
            }
        }
    })
end


Menu:CreateButton({
    Name = "Toggle Invisibility (You cannot interact)",
    Callback = function()
        if invisRunning then
            makeVisible(Players.LocalPlayer)
        else
            makeInvisible(Players.LocalPlayer)
        end
    end,
})


local Section = Menu:CreateSection("Misc")
local Button = Menu:CreateButton({
   Name = "TP to MAP",
   Callback = function()
       InvadeMatch()
    end,
})
local Button = Menu:CreateButton({
   Name = "Spy Priv Chats",
   Callback = function()
       CallSpy()
       _G.SpyExecuted = true
    end,
})

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")
local Section = VisualTab:CreateSection("Misc")
local Toggle =  VisualTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Callback = function(Value)
   	_G.Fullbright = Value
   	Fullbright()
   end,
})
local Button = VisualTab:CreateButton({
   Name = "No Fog",
   Callback = function()
       NoFog()
    end,
})
local Section = VisualTab:CreateSection("Player ESP")
local Toggle =  VisualTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Callback = function(Value)
   	_G.PlayerESP = Value
   	PlayerESP()
   end,
})
local ColorPicker = VisualTab:CreateColorPicker({
    Name = "Innocent Color",
    Color = CorInocente,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorInocente = Value
    end
})
local ColorPicker = VisualTab:CreateColorPicker({
    Name = "Beast Color",
    Color = CorBesta,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorBesta = Value
    end
})
local Section = VisualTab:CreateSection("Computer ESP")
local Toggle =  VisualTab:CreateToggle({
   Name = "Computer ESP",
   CurrentValue = false,
   Callback = function(Value)
   	_G.ComputerESP = Value
   	ComputerESP()
   end,
})
local Section = VisualTab:CreateSection("Capsule ESP")
local Toggle =  VisualTab:CreateToggle({
   Name = "Capsule ESP",
   CurrentValue = false,
   Callback = function(Value)
   	_G.FreezeESP = Value
   	FreezeESP()
   end,
})
local ColorPicker = VisualTab:CreateColorPicker({
    Name = "Capsule Color",
    Color = CorCapsula,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorCapsula = Value
    end
})
local Section = VisualTab:CreateSection("Exit ESP")
local Toggle =  VisualTab:CreateToggle({
   Name = "Exit ESP",
   CurrentValue = false,
   Callback = function(Value)
   	_G.ExitESP = Value
   	ExitESP()
   end,
})
local ColorPicker = VisualTab:CreateColorPicker({
    Name = "Exit Color",
    Color = CorSaida,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorSaida = Value
    end
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
   	_G.SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Anti Slow",
   CurrentValue = false,
   Callback = function(Value)
   	_G.NoSlow = Value
   	NoSlow()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	_G.NoClip = Value
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
   	_G.SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	_G.InfJump = Value
   	InfJump()
   end,
})

-- Credits.
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Creator")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Co-Dev")
local Label = Credits:CreateLabel("Discord: world_star_hacker", "at-sign")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
local Button = Credits:CreateButton({
   Name = "Copy Server Link",
   Callback = function()
   	setclipboard("discord.gg/AESCuek87s")
   	toclipboard("discord.gg/AESCuek87s")
    end,
})

while true do
	if game.Players.LocalPlayer:FindFirstChild("PlayerGui") then
		if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MenusTabFrame.Visible == false or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MenusTabFrame.Active == false then
			game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MenusTabFrame.Visible = true
			game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MenusTabFrame.Active = true
		end
	end
	wait(1)
end
