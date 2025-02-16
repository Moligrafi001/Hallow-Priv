-- Load the Rayfield library
if _G.Rayfield then
    _G.Rayfield:Destroy()
    _G.Rayfield = nil
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local localplayer = Players.LocalPlayer -- Define localplayer here
local playerGui = localplayer:WaitForChild("PlayerGui")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Rayfield Window Setup
local Window = Rayfield:CreateWindow({
    Name = "HallowHub | ⭐MurderMystery2🩸",
    LoadingTitle = "HallowHub",
    LoadingSubtitle = "by MoliGrafi & PrismX",
    Theme = "Amethyst"
})
-- function space

local NuclearFPS = {
    Active = false,
    Original = {},
    Connections = {}
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

-- Lock variable to prevent multiple script executions
local isRunning = false
local coinCollectorThread
local hasReset = false -- Flag to track if the character has been reset
local hasExecutedOnce = false -- Flag to ensure second script executes only once

local TWEEN_SPEED = 20
local TELEPORT_DISTANCE = 200

-- Function to execute the coin collection script
local function startCoinCollector()
    if isRunning then return end
    isRunning = true

    -- Get the local player
    local localPlayer = Players.LocalPlayer

    -- Function to get the current character and ensure it's fully loaded
    local function getCharacter()
        return localPlayer.Character or localPlayer.CharacterAdded:Wait()
    end

    -- Initialize character and humanoidRootPart
    local function initializeCharacter()
        local character = getCharacter()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
        local humanoid = character:WaitForChild("Humanoid", 5)
        return character, humanoidRootPart, humanoid
    end

    -- Variables for character and humanoid
    local character, humanoidRootPart, humanoid = initializeCharacter()

    if not humanoidRootPart then
        warn("HumanoidRootPart not found!")
        isRunning = false
        return
    end

    if not humanoid then
        warn("Humanoid not found!")
        isRunning = false
        return
    end

    -- List of possible maps and their CoinContainer paths
    local mapPaths = {
        "IceCastle",
        "SkiLodge",
        "Station",
        "LogCabin",
        "Bank2",
        "BioLab",
        "House2",
        "Factory",
        "Hospital3",
        "Hotel",
        "Mansion2",
        "MilBase",
        "Office3",
        "PoliceStation",
        "Workplace",
        "ResearchFacility",
        "ChristmasItaly"
    }

    -- Keep track of visited coins to prevent revisiting
    local visitedCoins = {}

    -- Function to find the active map's CoinContainer
    local function findActiveCoinContainer()
        for _, mapName in ipairs(mapPaths) do
            local map = Workspace:FindFirstChild(mapName)
            if map then
                local coinContainer = map:FindFirstChild("CoinContainer")
                if coinContainer then
                    return coinContainer
                end
            end
        end
        return nil
    end

    -- Function to find the nearest coin
    local function findNearestCoin(coinContainer)
        local nearestCoin = nil
        local shortestDistance = math.huge

        if coinContainer then
            for _, coin in ipairs(coinContainer:GetChildren()) do
                if coin:IsA("BasePart") and not visitedCoins[coin] then
                    local distance = (humanoidRootPart.Position - coin.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestCoin = coin
                    end
                end
            end
        else
            warn("CoinContainer not found or empty!")
        end

        return nearestCoin
    end

    -- Function to teleport to a coin
    local function teleportToCoin(coin)
        if coin then
            humanoidRootPart.CFrame = CFrame.new(coin.Position)
            visitedCoins[coin] = true -- Mark the coin as visited
        else
            warn("No coin to teleport to!")
        end
    end

    -- Function to tween to a coin
    local function tweenToCoin(coin)
        if coin then
            visitedCoins[coin] = true -- Mark the coin as visited
            local distance = (humanoidRootPart.Position - coin.Position).Magnitude
            local tweenInfo = TweenInfo.new(distance / TWEEN_SPEED, Enum.EasingStyle.Linear)
            local goal = {CFrame = CFrame.new(coin.Position)}
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
            tween:Play()

            -- When the tween starts, enable auto reset
            hasReset = false -- Allow reset once the tween starts

            tween.Completed:Wait() -- Wait for the tween to finish
        else
            warn("No coin to tween to!")
        end
    end

    -- Function to play falling animation
    local function playFallingAnimation()
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
    end

    -- Function to check if all CoinVisuals are gone and reset character
    local function checkForAllCoinVisualsGone()
        local coinContainer = findActiveCoinContainer()

        if coinContainer then
            local allCoinVisualsGone = true

            -- Check if any coin still has a CoinVisual
            for _, coin in ipairs(coinContainer:GetChildren()) do
                if coin:IsA("BasePart") then
                    local coinVisual = coin:FindFirstChild("CoinVisual")
                    if coinVisual then
                        allCoinVisualsGone = false
                        break
                    end
                end
            end

            -- If all CoinVisuals are gone and the character has not reset, reset the character
            if allCoinVisualsGone and not hasReset then
                character:BreakJoints() -- Reset character
                visitedCoins = {} -- Reset visited coins to allow collection again
                hasReset = true -- Set the reset flag
                wait(1) -- Wait before continuing after reset
            end

            -- If all CoinVisuals are gone, execute the second script once
            if allCoinVisualsGone and not hasExecutedOnce then
                hasExecutedOnce = true
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Ezqhs/-/refs/heads/main/auxqvoa"))()
            end

            -- Stop teleporting and tweening if all CoinVisuals are gone
            if allCoinVisualsGone then
                isRunning = false
            end
        end
    end

    -- Main function to tween or teleport to nearest coins
    local function collectCoins()
        while isRunning do
            -- Ensure the character and humanoid are initialized
            if not character or not humanoidRootPart or not humanoid or not character.Parent then
                character, humanoidRootPart, humanoid = initializeCharacter()
            end

            -- Find the active map's CoinContainer
            local coinContainer = findActiveCoinContainer()
            if not coinContainer then
                warn("No active map with a CoinContainer found. Retrying...")
                wait(0.01)
                continue
            end

            -- Find the nearest coin
            local targetCoin = findNearestCoin(coinContainer)
            if not targetCoin then
                warn("No unvisited coins available in the active map. Retrying...")
                wait(0.01)
                continue
            end

            -- Check if all CoinVisuals are gone and stop if necessary
            checkForAllCoinVisualsGone()
            if not isRunning then break end -- Stop the loop if all CoinVisuals are gone

            -- Check distance and decide whether to teleport or tween
            local distanceToCoin = (humanoidRootPart.Position - targetCoin.Position).Magnitude
            if distanceToCoin >= TELEPORT_DISTANCE then
                teleportToCoin(targetCoin)
            else
                tweenToCoin(targetCoin)
            end

            -- Play falling animation during tween
            playFallingAnimation()

            -- Check if all CoinVisuals are gone and reset if necessary
            checkForAllCoinVisualsGone()

            wait(0.01) -- Add a small wait to prevent script from running too quickly
        end
    end

    -- Start the coin collection process
    collectCoins()
end

-- Function to stop the coin collector
local function stopCoinCollector()
    isRunning = false
    if coinCollectorThread then
        coinCollectorThread:Disconnect()
        coinCollectorThread = nil
    end
end

-- Function to handle new round detection (this is just an example, adjust as needed)
local function onNewRound()
    -- Reset the hasReset flag when a new round starts
    hasReset = false
    hasExecutedOnce = false -- Allow the second script to execute again in the new round

    -- Start the coin collector again
    if not isRunning then
        coinCollectorThread = game:GetService("RunService").Heartbeat:Connect(startCoinCollector)
    end
end


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


local function DestroyGraphics()
    -- Annihilate terrain features
    workspace.Terrain.WaterWaveSize = 0
    workspace.Terrain.WaterWaveSpeed = 0
    workspace.Terrain.WaterTransparency = 1
    workspace.Terrain:Clear()
    
    -- Obliterate lighting effects
    game.Lighting.GlobalShadows = false
    game.Lighting.FogEnd = 9e9
    game:GetService("Lighting").Technology = "ShadowMap"
    
    -- Massacre rendering quality
    settings().Rendering.QualityLevel = 0
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level00
    
    -- Execute visual elements
    for _, obj in ipairs(workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("BasePart") then
                -- Destroy part visuals
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.Transparency = 0.5
                if obj:IsA("MeshPart") then
                    obj.TextureID = ""
                end
            end
            if obj:IsA("ParticleEmitter") then
                obj.Lifetime = NumberRange.new(0)
            end
            if obj:IsA("PostEffect") then
                obj.Enabled = false
            end
            if obj:IsA("Decal") then
                obj:Destroy()
            end
        end)
    end
    
    -- Prevent visual regeneration
    NuclearFPS.Connections.descendantAdded = workspace.DescendantAdded:Connect(function(child)
        pcall(function()
            if child:IsA("BasePart") then
                child.Material = Enum.Material.Plastic
                child.Reflectance = 0
            end
            if child:IsA("ParticleEmitter") or child:IsA("Sparkles") then
                child:Destroy()
            end
        end)
    end)
    
    -- Liquidate character details
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                pcall(function()
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                        part.Reflectance = 0
                    end
                    if part:IsA("Accessory") then
                        part.Handle.Transparency = 1
                    end
                end)
            end
        end
    end
end

local function getMap()
    for _, o in ipairs(workspace:GetChildren()) do
        if o:FindFirstChild("CoinContainer") and o:FindFirstChild("Spawns") then
            return o
        end
    end
    return nil
end

local function findMurderer()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Knife") then
            return player.Character
        end
    end
    return nil
end

local function followMurderer()
    while true do
        local murdererCharacter = findMurderer()

        if murdererCharacter and murdererCharacter:FindFirstChild("UpperTorso") then
            local murdererTorso = murdererCharacter.UpperTorso

            if Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
                -- Calculate position behind the murderer
                local behindPosition = murdererTorso.Position - murdererTorso.CFrame.LookVector * 5

                -- Update player's position to follow the murderer
                Plr.Character.HumanoidRootPart.CFrame = CFrame.new(behindPosition, murdererTorso.Position)
            end
        end

        task.wait(0.1)
    end
end


local function findSheriff()
    -- Try to find the sheriff by checking the Gun in Backpack or Character
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
            return player
        end
    end

    -- Fallback: Check playerData for the Sheriff role
    if playerData then
        for player, data in pairs(playerData) do
            if data.Role == "Sheriff" then
                return game.Players:FindFirstChild(player)
            end
        end
    end
    return nil
end

local function findSheriffThatsNotMe()
    -- Try to find the sheriff by checking the Gun in Backpack or Character, excluding the local player
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player == localplayer then continue end
        if player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
            return player
        end
    end

    -- Fallback: Check playerData for the Sheriff role, excluding the local player
    if playerData then
        for player, data in pairs(playerData) do
            if data.Role == "Sheriff" and game.Players:FindFirstChild(player) ~= localplayer then
                return game.Players:FindFirstChild(player)
            end
        end
    end
    return nil
end
--FLING LINE WIP
--[[function miniFling(playerToFling)
    local a = game.Players.LocalPlayer
    local b = a:GetMouse()
    local c = {playerToFling}
    local d = game:GetService("Players")
    local e = d.LocalPlayer
    local f = false

    local function g(h)
        local i = e.Character
        local j = i and i:FindFirstChildOfClass("Humanoid")
        local k = j and j.RootPart
        local l = h.Character
        local m, n, o, p, q

        if l:FindFirstChildOfClass("Humanoid") then
            m = l:FindFirstChildOfClass("Humanoid")
        end
        if m and m.RootPart then
            n = m.RootPart
        end
        if l:FindFirstChild("Head") then
            o = l.Head
        end
        if l:FindFirstChildOfClass("Accessory") then
            p = l:FindFirstChildOfClass("Accessory")
        end
        if p and p:FindFirstChild("Handle") then
            q = p.Handle
        end

        if i and j and k then
            if k.Velocity.Magnitude < 50 then
                getgenv().OldPos = k.CFrame
            end

            if m and m.Sit and not f then
            end

            if o then
                if o.Velocity.Magnitude > 500 then
                    fu.dialog("Player flung", "Player is already flung. Fling again?", {"Fling again", "No"})
                    if fu.waitfordialog() == "No" then
                        return fu.closedialog()
                    end
                    fu.closedialog()
                end
            elseif not o and q then
                if q.Velocity.Magnitude > 500 then
                    fu.dialog("Player flung", "Player is already flung. Fling again?", {"Fling again", "No"})
                    if fu.waitfordialog() == "No" then
                        return fu.closedialog()
                    end
                    fu.closedialog()
                end
            end

            if o then
                workspace.CurrentCamera.CameraSubject = o
            elseif not o and q then
                workspace.CurrentCamera.CameraSubject = q
            elseif m and n then
                workspace.CurrentCamera.CameraSubject = m
            end

            if not l:FindFirstChildWhichIsA("BasePart") then
                return
            end

            local function r(s, t, u)
                k.CFrame = CFrame.new(s.Position) * t * u
                i:SetPrimaryPartCFrame(CFrame.new(s.Position) * t * u)
                k.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                k.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end

            local function v(s)
                local w = 2
                local x = tick()
                local y = 0

                repeat
                    if k and m then
                        if s.Velocity.Magnitude < 50 then
                            y = y + 100
                            r(s, CFrame.new(0, 1.5, 0) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, 0) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                            task.wait()
                            r(s, CFrame.new(2.25, 1.5, -2.25) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                            task.wait()
                            r(s, CFrame.new(-2.25, -1.5, 2.25) + m.MoveDirection * s.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(y), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, 1.5, 0) + m.MoveDirection, CFrame.Angles(math.rad(y), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, 0) + m.MoveDirection, CFrame.Angles(math.rad(y), 0, 0))
                            task.wait()
                        else
                            r(s, CFrame.new(0, 1.5, m.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, -m.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, 1.5, m.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, 1.5, n.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, -n.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, 1.5, n.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                            task.wait()
                            r(s, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    else
                        break
                    end
                until s.Velocity.Magnitude > 500 or s.Parent ~= h.Character or h.Parent ~= d or h.Character ~= l or m.Sit or j.Health <= 0 or tick() > x + w
            end

            workspace.FallenPartsDestroyHeight = 0 / 0
            local z = Instance.new("BodyVelocity")
            z.Name = "EpixVel"
            z.Parent = k
            z.Velocity = Vector3.new(9e8, 9e8, 9e8)
            z.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
            j:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

            if n and o then
                if (n.CFrame.p - o.CFrame.p).Magnitude > 5 then
                    v(o)
                else
                    v(n)
                end
            elseif n and not o then
                v(n)
            elseif not n and o then
                v(o)
            elseif not n and not o and p and q then
                v(q)
            else
                fu.notification("Can't find a proper part of target player to fling.")
            end

            -- Schedule cleanup after 3 seconds
            task.delay(3, function()
                -- Destroy the BodyVelocity
                if z and z.Parent then
                    z:Destroy()
                end

                -- Clear all velocities
                for _, part in ipairs(i:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Velocity = Vector3.new()
                        part.RotVelocity = Vector3.new()
                    end
                end

                -- Reset humanoid state
                j:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                workspace.CurrentCamera.CameraSubject = j

                -- Reset FallenPartsDestroyHeight
                workspace.FallenPartsDestroyHeight = getgenv().FPDH or 500

                -- Force humanoid into a neutral state
                j:ChangeState("Physics")
                task.wait()
                j:ChangeState("GettingUp")
            end)
        else
            fu.notification("No valid character of said target player. May have died.")
        end
    end

    g(c[1])
end ]]

-- Home Tab
local HomeTab = Window:CreateTab("🏠 Home", nil)
local MainSection = HomeTab:CreateSection("Cool Stuff", true)
        -- Define the invisibility toggle functionality
local invisRunning = false
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")

-- Define a notification function using Rayfield
local function notify(title, message)
    Rayfield:Notify({
        Title = title,
        Content = message,
        Duration = 6.5,
        Image = 4483362458, -- You can change this image ID if needed
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

-- Define the invisible function
local function makeInvisible(speaker)
    if invisRunning then return end
    invisRunning = true

    local Player = speaker
    repeat wait(.1) until Player.Character
    local Character = Player.Character
    Character.Archivable = true
    local IsInvis = false
    local IsRunning = true
    local InvisibleCharacter = Character:Clone()
    InvisibleCharacter.Parent = Lighting
    InvisibleCharacter.Name = ""
    local Void = workspace.FallenPartsDestroyHeight
    InvisibleCharacter.Name = ""
    local CF

    local invisFix = RunService.Stepped:Connect(function()
        pcall(function()
            local IsInteger
            if tostring(Void):find('-') then
                IsInteger = true
            else
                IsInteger = false
            end
            local Pos = Player.Character.HumanoidRootPart.Position
            local Pos_String = tostring(Pos)
            local Pos_Seperate = Pos_String:split(', ')
            local X = tonumber(Pos_Seperate[1])
            local Y = tonumber(Pos_Seperate[2])
            local Z = tonumber(Pos_Seperate[3])
            if IsInteger == true then
                if Y <= Void then
                    Respawn()
                end
            elseif IsInteger == false then
                if Y >= Void then
                    Respawn()
                end
            end
        end)
    end)

    -- Set transparency of the invisible clone
    for _,v in pairs(InvisibleCharacter:GetDescendants()) do
        if v:IsA("BasePart") then
            if v.Name == "HumanoidRootPart" then
                v.Transparency = 1
            else
                v.Transparency = .5
            end
        end
    end

    -- Respawn function to handle visibility
    function Respawn()
        IsRunning = false
        if IsInvis == true then
            pcall(function()
                Player.Character = Character
                wait()
                Character.Parent = workspace
                Character:FindFirstChildWhichIsA('Humanoid'):Destroy()
                IsInvis = false
                InvisibleCharacter.Parent = nil
                invisRunning = false
            end)
        elseif IsInvis == false then
            pcall(function()
                Player.Character = Character
                wait()
                Character.Parent = workspace
                Character:FindFirstChildWhichIsA('Humanoid'):Destroy()
                TurnVisible()
            end)
        end
    end

    -- Disconnect death event and respawn when character dies
    local invisDied
    invisDied = InvisibleCharacter:FindFirstChildOfClass('Humanoid').Died:Connect(function()
        Respawn()
        invisDied:Disconnect()
    end)

    -- If already invisible, return
    if IsInvis == true then return end
    IsInvis = true
    CF = workspace.CurrentCamera.CFrame
    local CF_1 = Player.Character.HumanoidRootPart.CFrame
    Character:MoveTo(Vector3.new(0, math.pi * 1000000, 0))
    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    wait(.2)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    InvisibleCharacter = InvisibleCharacter
    Character.Parent = Lighting
    InvisibleCharacter.Parent = workspace
    InvisibleCharacter.HumanoidRootPart.CFrame = CF_1
    Player.Character = InvisibleCharacter
    
    -- Fix the camera to follow the new character
    workspace.CurrentCamera.CameraSubject = InvisibleCharacter:FindFirstChild("HumanoidRootPart")
    
    Player.Character.Animate.Disabled = true
    Player.Character.Animate.Disabled = false

    -- Turn the character visible again
    function TurnVisible()
        if IsInvis == false then return end
        invisFix:Disconnect()
        invisDied:Disconnect()
        CF = workspace.CurrentCamera.CFrame
        Character = Character
        local CF_1 = Player.Character.HumanoidRootPart.CFrame
        Character.HumanoidRootPart.CFrame = CF_1
        InvisibleCharacter:Destroy()
        Player.Character = Character
        Character.Parent = workspace
        IsInvis = false
        Player.Character.Animate.Disabled = true
        Player.Character.Animate.Disabled = false
        invisDied = Character:FindFirstChildOfClass('Humanoid').Died:Connect(function()
            Respawn()
            invisDied:Disconnect()
        end)
        invisRunning = false
    end

    -- Send the notification when invisibility is activated
    notify('Invisible', 'You now appear invisible to other players')
end

-- Define the visible function
local function makeVisible(speaker)
    -- Call the TurnVisible function directly
    TurnVisible()
end

-- UI Button Code to Toggle Invisibility
HomeTab:CreateButton({
    Name = "Toggle Invisibility (GodMode)", -- Button name
    Callback = function()
        if invisRunning then
            -- If already invisible, make the player visible
            makeVisible(Players.LocalPlayer)
        else
            -- Otherwise, make the player invisible
            makeInvisible(Players.LocalPlayer)
        end
    end,
})

-- UI Button Code to Turn Visible
HomeTab:CreateButton({
    Name = "Turn Visible (UnGodMode)", -- Button name
    Callback = function()
        -- Call the function to make the player visible
        makeVisible(Players.LocalPlayer)
    end,
})

local XRayActive = false  -- Track the state of X-Ray

local Toggle = HomeTab:CreateToggle({
    Name = "X-Ray",
    Callback = function(Value)
        XRayActive = Value  -- Set the active state based on toggle

        if XRayActive then
            -- Enable X-Ray
            print("X-Ray Enabled")
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Transparency < 1 then
                    obj.LocalTransparencyModifier = 0.7  -- Adjust transparency for X-Ray effect
                end
            end

            Rayfield:Notify({
                Title = "X-Ray Activated",
                Content = "You can now see through walls!",
                Duration = 4,
                Image = 4483362458,
            })
        else
            -- Disable X-Ray
            print("X-Ray Disabled")
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Transparency < 1 then
                    obj.LocalTransparencyModifier = 0  -- Restore original transparency
                end
            end

            Rayfield:Notify({
                Title = "X-Ray Deactivated",
                Content = "Visuals have been restored.",
                Duration = 4,
                Image = 4483362458,
            })
        end
    end
})


HomeTab:CreateButton({
    Name = "FPS boost - AntiLag", -- Button name
    Callback = function()
        local Terrain = workspace:FindFirstChildOfClass('Terrain')
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 0
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	settings().Rendering.QualityLevel = 1
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i,v in pairs(Lighting:GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
	workspace.DescendantAdded:Connect(function(child)
		task.spawn(function()
			if child:IsA('ForceField') then
				RunService.Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Sparkles') then
				RunService.Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Smoke') or child:IsA('Fire') then
				RunService.Heartbeat:Wait()
				child:Destroy()
			end
		end)
	end)
    end,
})


local section = HomeTab:CreateSection("Toggle AutoFarm", true)

local Toggle = HomeTab:CreateToggle({
    Name = "Toggle AutoFarm",    
    CurrentValue = false,        
    Flag = "AutoF",            
    Callback = function(Value)   
        if Value then
            -- If toggle is turned on (value is true)
            if not isRunning then
                -- Start the coin collection process if not already running
                coinCollectorThread = game:GetService("RunService").Heartbeat:Connect(startCoinCollector)
            end
        else
            -- If toggle is turned off (value is false)
            stopCoinCollector()
            if coinCollectorThread then
                -- Disconnect the Heartbeat connection if coin collection is stopped
                coinCollectorThread:Disconnect()
            end
        end
    end,
})
local PlayerTab = Window:CreateTab("🕴️Player", nil)

local EspSection = PlayerTab:CreateSection("Esp's", true)

-- ESP Setup
local ESPToggle = false
local faces = {"Back", "Bottom", "Front", "Left", "Right", "Top"}

-- Function to create the ESP
function MakeESP()
    for _, v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            if not v.Character or not v.Character:FindFirstChild("Head") then
                continue
            end
            
            -- Create the BillboardGui for ESP
            local bgui = Instance.new("BillboardGui", v.Character.Head)
            bgui.Name = "EGUI"
            bgui.AlwaysOnTop = true
            bgui.ExtentsOffset = Vector3.new(0, 2, 0)
            bgui.Size = UDim2.new(0, 200, 0, 50)
            
            -- Create the TextLabel to show the player name
            local nam = Instance.new("TextLabel", bgui)
            nam.Text = v.Name
            nam.BackgroundTransparency = 1
            nam.TextSize = 15
            nam.Font = "GothamBold"
            nam.TextColor3 = Color3.new(255, 255, 255)
            nam.Size = UDim2.new(0, 200, 0, 50)

            -- Add color coding for weapons
            if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                -- For Gun
                for _, p in pairs(v.Character:GetChildren()) do
                    if p:IsA("Part") then
                        for _, f in pairs(faces) do
                            local m = Instance.new("SurfaceGui", p)
                            m.Name = "EGUI"
                            m.Face = f
                            m.AlwaysOnTop = true
                            local mf = Instance.new("Frame", m)
                            mf.Size = UDim2.new(1, 0, 1, 0)
                            mf.BorderSizePixel = 0
                            mf.BackgroundTransparency = 0.5
                            mf.BackgroundColor3 = Color3.new(0, 0, 255)
                        end
                    end
                end
            elseif v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                -- For Knife
                for _, p in pairs(v.Character:GetChildren()) do
                    if p:IsA("Part") then
                        for _, f in pairs(faces) do
                            local m = Instance.new("SurfaceGui", p)
                            m.Name = "EGUI"
                            m.Face = f
                            m.AlwaysOnTop = true
                            local mf = Instance.new("Frame", m)
                            mf.Size = UDim2.new(1, 0, 1, 0)
                            mf.BorderSizePixel = 0
                            mf.BackgroundTransparency = 0.5
                            mf.BackgroundColor3 = Color3.new(255, 0, 0)
                        end
                    end
                end
            else
                -- For Default
                for _, p in pairs(v.Character:GetChildren()) do
                    if p:IsA("Part") then
                        for _, f in pairs(faces) do
                            local m = Instance.new("SurfaceGui", p)
                            m.Name = "EGUI"
                            m.Face = f
                            m.AlwaysOnTop = true
                            local mf = Instance.new("Frame", m)
                            mf.Size = UDim2.new(1, 0, 1, 0)
                            mf.BorderSizePixel = 0
                            mf.BackgroundTransparency = 0.5
                            mf.BackgroundColor3 = Color3.new(255, 255, 255)
                        end
                    end
                end
            end
        end
    end
end

-- Function to clear the existing ESP
function ClearESP()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name == "EGUI" then
            v:Destroy()
        end
    end
end

-- Continuous Refresh ESP (only if ESP is enabled)
game:GetService("RunService").Heartbeat:Connect(function()
    if ESPToggle then
        pcall(ClearESP)
        pcall(MakeESP)
    end
end)


-- ESP Toggle Button
PlayerTab:CreateButton({
    Name = "Toggle ESP",
    Callback = function()
        if ESPToggle == false then
            ESPToggle = true
            game.StarterGui:SetCore("SendNotification", {
                Title = "ESP Enabled",
                Text = "ESP is now enabled and refreshing continuously.",
                Duration = 5,
            })
        else
            ESPToggle = false
            pcall(ClearESP)
            game.StarterGui:SetCore("SendNotification", {
                Title = "ESP Disabled",
                Text = "ESP has been disabled.",
                Duration = 5,
            })
        end
    end
})

local ESPEnabled = false  -- State variable to toggle ESP
local espConnection -- Declare the variable to hold the event connection

PlayerTab:CreateButton({
    Name = "Gun/Trap ESP",
    Callback = function()
        -- Function to enable ESP
        local function EnableESP()
            ESPEnabled = true

            -- Check if the event connection exists; if not, create it
            if not espConnection then
                espConnection = workspace.DescendantAdded:Connect(function(ch)
                    if not ESPEnabled then return end  -- Exit if ESP is disabled

                    -- Trap detection and ESP
                    if ch.Name == "Trap" and ch.Parent:IsDescendantOf(workspace) then
                        ch.Transparency = 0
                        local trapesp = Instance.new("Highlight")
                        trapesp.Parent = workspace
                        trapesp.Adornee = ch
                        trapesp.OutlineTransparency = 0.5
                        trapesp.FillTransparency = 0.5
                        trapesp.FillColor = Color3.fromRGB(255, 0, 0)
                        trapesp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                        Rayfield:Notify({
                            Title = "Trap Detected!",
                            Content = "Murderer has placed a trap!",
                            Duration = 5.0,
                        })
                    end

                    -- Gun drop detection and ESP
                    if ch.Name == "GunDrop" then
                        local gunESP = Instance.new("Highlight")
                        gunESP.Parent = workspace
                        gunESP.Adornee = ch
                        gunESP.OutlineTransparency = 0.5
                        gunESP.FillTransparency = 0.5
                        gunESP.FillColor = Color3.fromRGB(255, 255, 0)
                        gunESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                        Rayfield:Notify({
                            Title = "Gun Dropped!",
                            Content = "A yellow highlight marks the dropped gun.",
                            Duration = 5.0,
                        })
                    end
                end)
            end
        end

        -- Function to disable ESP
        local function DisableESP()
            ESPEnabled = false

            -- Clear existing ESP highlights
            for _, highlight in ipairs(workspace:GetDescendants()) do
                if highlight:IsA("Highlight") and (highlight.Adornee.Name == "Trap" or highlight.Adornee.Name == "GunDrop") then
                    highlight:Destroy()
                end
            end

            -- Disconnect the event when disabling ESP
            if espConnection then
                espConnection:Disconnect()
                espConnection = nil
            end

            Rayfield:Notify({
                Title = "ESP Disabled",
                Content = "Gun and Trap ESP have been disabled.",
                Duration = 5.0,
            })
        end

        -- Toggle ESP state (enable/disable)
        if not ESPEnabled then
            EnableESP()
            Rayfield:Notify({
                Title = "ESP Enabled",
                Content = "Gun and Trap ESP are now active.",
                Duration = 5.0,
            })
        else
            DisableESP()
        end
    end,
})


local ChatSection = PlayerTab:CreateSection("ChatThings", true)

PlayerTab:CreateButton({
    Name = "Send Sheriff and Murderer Names",
    Callback = function()
        -- Function to find the murderer
        local function findMurderer()
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife")) then
                    return player
                end
            end
            return nil
        end

        -- Function to find the sheriff
        local function findSheriff()
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun")) then
                    return player
                end
            end
        end

        -- Get all text channels
        local textchannels = game:GetService("TextChatService"):WaitForChild("TextChannels"):GetChildren()
        for _, textchannel in ipairs(textchannels) do
            if textchannel.Name == "RBXSystem" then continue end

            -- Find the murderer and sheriff
            local murd = findMurderer()
            local sher = findSheriff()

            -- Format names
            local murdName = murd and murd.Name or "No Murderer"
            local sherName = sher and sher.Name or "No Sheriff"

            -- Create the message
            local message = string.format(
                "Murderer: %s | Sheriff: %s",
                murdName,
                sherName
            )

            -- Send the message
            textchannel:SendAsync(message)
        end
    end,
})

local CharacterSection = PlayerTab:CreateSection("Player Stuff", true)

local Section = PlayerTab:CreateSection("Walk")
local Input = PlayerTab:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = PlayerTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = PlayerTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
local Section = PlayerTab:CreateSection("Jump")
local Input = PlayerTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = PlayerTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = PlayerTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})

local TeleportsTab = Window:CreateTab("Teleports⬆️", nil)
local teleportSection = TeleportsTab:CreateSection("teleport Locations", true)


TeleportsTab:CreateButton({
    Name = "Teleport To Lobby",
    Callback = function()
        local player = game.Players.LocalPlayer  -- Get the local player
        if player and player.Character then
            -- Teleport the player's character to the specified position
            player.Character:MoveTo(Vector3.new(-107, 152, 41))
        else
            warn("Character not found or player unavailable.")
        end
    end,
})

-- Function to get the map (this looks fine based on your provided code)
local function getMap()
    for _, o in ipairs(workspace:GetChildren()) do
        if o:FindFirstChild("CoinContainer") and o:FindFirstChild("Spawns") then
            return o
        end
    end
    return nil
end

-- Button creation for teleporting to map

TeleportsTab:CreateButton({
    Name = "Teleport To Map",
    Callback = function()
        -- Teleport to map function
        local function Teleport_to_map()
            -- Get the map using the getMap() function
            local map = getMap()

            -- Check if the map is found
            if not map then
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "No map found.",
                    Duration = 6.5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("No map found.")
                            end
                        },
                    },
                })
                return
            end

            -- Find the Spawns folder inside the map
            local spawnsFolder = map:FindFirstChild("Spawns")
            if not spawnsFolder then
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "No Spawns folder found in the map.",
                    Duration = 6.5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("No Spawns folder found.")
                            end
                        },
                    },
                })
                return
            end

            -- Get all spawn points
            local spawns = spawnsFolder:GetChildren()
            if #spawns == 0 then
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "No spawn points found in the map.",
                    Duration = 6.5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("No spawn points found.")
                            end
                        },
                    },
                })
                return
            end

            -- Select a random spawn point
            local randomSpawn = spawns[math.random(1, #spawns)]

            -- Ensure the local player exists
            local player = game.Players.LocalPlayer
            if player then
                -- Wait for the character if it's not yet available
                if not player.Character then
                    player.CharacterAdded:Wait()  -- Wait for the character to be added
                end

                -- Wait for the character's HumanoidRootPart to be fully loaded
                local character = player.Character
                if not character:FindFirstChild("HumanoidRootPart") then
                    character:WaitForChild("HumanoidRootPart")  -- Wait until it's fully loaded
                end

                -- Now move the player's character to the spawn point
                character:MoveTo(randomSpawn.Position)

                -- Notify success
                Rayfield:Notify({
                    Title = "Teleport Successful",
                    Content = "You have been teleported to the map.",
                    Duration = 6.5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("Teleport successful!")
                            end
                        },
                    },
                })
            else
                Rayfield:Notify({
                    Title = "Teleport Failed",
                    Content = "Player not found.",
                    Duration = 6.5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("Player not found.")
                            end
                        },
                    },
                })
            end
        end

        -- Call the teleport function when the button is clicked
        Teleport_to_map()
    end,
})

local teleportSection = TeleportsTab:CreateSection("teleport Items", true)

TeleportsTab:CreateButton({                                                
    Name = "Teleport to Dropped Gun",
    Callback = function()
        local player = game.Players.LocalPlayer  -- Get the local player

        -- Ensure the player and their character exist
        if not player or not player.Character then
            warn("Player or character not available.")
            return
        end
 
        -- Check for the map and the dropped gun
        local map = getMap()
        if not map then
            Rayfield:Notify({
                Title = "No Map Found",
                Content = "The map could not be located.",
                Duration = 5.0,
            })
            return
        end

        local gunDrop = map:FindFirstChild("GunDrop")
        if not gunDrop then
            Rayfield:Notify({
                Title = "No Dropped Gun",
                Content = "There is no dropped gun to teleport to.",
                Duration = 5.0,
            })
            return
        end

        -- Store the player's current position
        local previousPosition = player.Character:GetPivot()

        -- Teleport to the dropped gun
        player.Character:PivotTo(gunDrop:GetPivot())

        -- Wait for the gun to be picked up
        player.Backpack.ChildAdded:Wait()

        -- Teleport back to the previous position
        player.Character:PivotTo(previousPosition)

        -- Notify the player
        Rayfield:Notify({
            Title = "Gun Picked Up",
            Content = "You have picked up the dropped gun and teleported back.",
            Duration = 5.0,
        })
    end,
})

-- Teleport tool (Only works if Anti-Kick is enabled)
TeleportsTab:CreateButton({
    Name = "Teleport Tool",
    Callback = function()
        
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        -- Create the Teleport Tool
        local tool = Instance.new("Tool")
        tool.Name = "TeleportTool"
        tool.RequiresHandle = false
        tool.Parent = player.Backpack -- Add the tool to the player's backpack

        -- Function to handle teleporting when the tool is activated
        local function onActivated()
            -- Check if the character is valid
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return
            end

            -- Get the mouse and the clicked position
            local mouse = player:GetMouse()
            local position = mouse.Hit.p

            -- Teleport the character to the clicked position
            character.HumanoidRootPart.CFrame = CFrame.new(position)
        end

        -- Connect the Activated event of the tool to the onActivated function
        tool.Activated:Connect(onActivated)

        print("Teleport Tool created. Equip it and click anywhere to teleport.")
    end,
})

local MiscTab = Window:CreateTab("Misc🎲 (Kill)", nil)
local KillSection = MiscTab:CreateSection("If you are Innocent -", true)
local WIP = MiscTab:CreateLabel("W.I.P - Fling Sheriff/Murder",SectionParent)

-- Fling Sheriff Button
--[[Fling_Sheriff_Button = MiscTab:CreateButton({
    Name = "Fling Sheriff",
    Info = "Flings the sheriff/hero.", -- Description of the button
    Interact = 'Changable', -- You can change this to suit your needs
    Callback = function()
        -- Check if sheriff is found
        if not findSheriff() then
            Rayfield:Notify({
                Title = "No Sheriff",
                Content = "No sheriff/hero to fling.",
                Duration = 5.0,
                Image = 4483362458, -- Example icon
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

        -- Perform fling action
        miniFling(findSheriff())
        
        -- Notify that the sheriff has been flung
        Rayfield:Notify({
            Title = "Sheriff Flinged",
            Content = "The sheriff/hero has been flung!",
            Duration = 5.0,
            Image = 4483362458, -- Fling icon
        })
    end,
})
]]

-- Fling Murderer Button
--[[Fling_Murderer_Button = MiscTab:CreateButton({
    Name = "Fling Murderer",
    Info = "Flings the murderer.", -- Description of the button
    Interact = 'Changable', -- You can change this to suit your needs
    Callback = function()
        -- Check if murderer is found
        if not findMurderer() then
            Rayfield:Notify({
                Title = "No Murderer",
                Content = "No murderer to fling.",
                Duration = 5.0,
                Image = 4483362458, -- Example icon
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

        -- Perform fling action
        miniFling(findMurderer())
        
        -- Notify that the murderer has been flung
        Rayfield:Notify({
            Title = "Murderer Flinged",
            Content = "The murderer has been flung!",
            Duration = 5.0,
            Image = 4483362458, -- Fling icon
        })
    end,
})
]]
local Plr = game:GetService("Players").LocalPlayer

local Kill2Section = MiscTab:CreateSection("If you are Sheriff -", true)

MiscTab:CreateButton({
    Name = "Shoot Murderer",
    Callback = function()
        local murdererCharacter = findMurderer()  -- Find the murderer's character

        if murdererCharacter then
            print("Murderer found: " .. murdererCharacter.Name)

            -- Check if LocalPlayer's character and gun exist
            if Plr.Character and (Plr.Character:FindFirstChild("Gun") or Plr.Backpack:FindFirstChild("Gun")) then
                local gun = Plr.Character:FindFirstChild("Gun") or Plr.Backpack:FindFirstChild("Gun")

                -- Move gun to character if in backpack
                if Plr.Backpack:FindFirstChild("Gun") then
                    Plr.Backpack.Gun.Parent = Plr.Character
                end

                local murdererTorso = murdererCharacter:FindFirstChild("UpperTorso") or murdererCharacter:FindFirstChild("HumanoidRootPart")

                if murdererTorso then
                    print("Following murderer: " .. murdererCharacter.Name)

                    -- Start following behind the murderer
                    spawn(function()
                        while murdererTorso and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") do
                            local murdererHumanoid = murdererCharacter:FindFirstChild("Humanoid")
                            if murdererHumanoid and murdererHumanoid.Health <= 0 then
                                print("Murderer is dead. Stopping follow.")
                                break
                            end

                            -- Position behind the murderer
                            local behindPosition = murdererTorso.Position - murdererTorso.CFrame.LookVector * 5
                            Plr.Character.HumanoidRootPart.CFrame = CFrame.new(behindPosition, murdererTorso.Position)

                            task.wait(0.1)
                        end
                    end)

                    -- Immediately position the player behind the murderer before shooting
                    local behindPosition = murdererTorso.Position - murdererTorso.CFrame.LookVector * 5
                    Plr.Character.HumanoidRootPart.CFrame = CFrame.new(behindPosition, murdererTorso.Position)

                    -- Shoot the murderer
                    local shoot = gun:FindFirstChild("Shoot")
                    if shoot then
                        shoot:FireServer(murdererTorso.Position)
                        print("Shot fired at: " .. tostring(murdererTorso.Position))
                    else
                        warn("Gun Shoot function not found.")
                    end
                else
                    warn("Murderer's torso or root part not found.")
                end
            else
                warn("Sheriff has no gun or character missing.")
            end
        else
            warn("Murderer not found.")
        end

        task.wait(0.05)
    end
})






local Kill3Section = MiscTab:CreateSection("If you are Murderer -", true)

local function validateMurderer()
    -- Ensure local player exists and has loaded
    if not localplayer then
        return false, "Local player not found"
    end
    
    -- Wait for character if not loaded
    if not localplayer.Character then
        localplayer.CharacterAdded:Wait()
    end
    
    -- Ensure critical components exist
    if not localplayer.Character:FindFirstChild("Humanoid") then
        return false, "Humanoid not found"
    end
    
    if not localplayer.Character:FindFirstChild("HumanoidRootPart") then
        return false, "HumanoidRootPart not found"
    end
    
    -- Check if player is murderer
    local knife = localplayer.Backpack:FindFirstChild("Knife") or localplayer.Character:FindFirstChild("Knife")
    if not knife then
        return false, "You're not the murderer"
    end
    
    return true, knife
end

local function findNearestPlayer()
    local closestPlayer, closestDistance = nil, math.huge
    local localRoot = localplayer.Character.HumanoidRootPart
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localplayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - localRoot.Position).Magnitude
            if distance < closestDistance then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer
end

MiscTab:CreateButton({
    Name = "Kill Closest Player as Murderer",
    Callback = function()
        local valid, knife = validateMurderer()
        if not valid then
            Rayfield:Notify({
                Title = "Error",
                Content = knife, -- Returns the error message
                Duration = 6.5,
                Image = 4483362458,
            })
            return
        end

        -- Find nearest player
        local target = findNearestPlayer()
        if not target then
            Rayfield:Notify({
                Title = "Error",
                Content = "No valid target found!",
                Duration = 6.5,
                Image = 4483362458,
            })
            return
        end

        -- Ensure knife is equipped
        if not localplayer.Character:FindFirstChild("Knife") then
            localplayer.Character.Humanoid:EquipTool(knife)
            wait(0.1) -- Allow time for equip
        end

        -- Perform kill
        local targetHRP = target.Character.HumanoidRootPart
        localplayer.Character.HumanoidRootPart.CFrame = targetHRP.CFrame + targetHRP.CFrame.LookVector * 2
        local args = {[1] = "Slash"}
        localplayer.Character.Knife.Stab:FireServer(unpack(args))

        Rayfield:Notify({
            Title = "Success",
            Content = "Killed "..target.Name,
            Duration = 3,
            Image = 4483362458,
        })
    end,
})

local Plr = game.Players.LocalPlayer

MiscTab:CreateButton({
    Name = "Kill EVERYONE as Murderer",
    Callback = function()
        for _, v in pairs(game:GetService("Players"):GetChildren()) do
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                -- Ensure the player has a Knife
                if Plr.Backpack:FindFirstChild("Knife") then
                    Plr.Backpack.Knife.Parent = Plr.Character
                end

                -- Teleport to the target player's position and perform the kill
                Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame

                local args = {
                    [1] = "Slash"
                }

                -- Fire the stab function
                if Plr.Character:FindFirstChild("Knife") then
                    Plr.Character.Knife:WaitForChild("Stab"):FireServer(unpack(args))
                end

                task.wait(0.8)
            end
        end
    end
})


local FlySection = MiscTab:CreateSection("Fly", true)
                                                                                                         --fly start

-- Variables:
local flying = false
local speed = 50  -- Start at a speed of 50
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastCtrl = {f = 0, b = 0, l = 0, r = 0}

-- Fly Function:
local function fly()
    local plr = game.Players.LocalPlayer
    local torso = plr.Character:WaitForChild("HumanoidRootPart")
    local bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = torso.CFrame

    local bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0, 0.1, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

    -- Movement loop:
    repeat wait()
        plr.Character.Humanoid.PlatformStand = true

        -- Immediate movement at current speed:
        if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) +
            ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed
            lastCtrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
        elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 then
            bv.velocity = Vector3.new(0, 0.1, 0)
        end

        bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed), 0, 0)
    until not flying
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastCtrl = {f = 0, b = 0, l = 0, r = 0}
    speed = 50  -- Reset to the starting speed
    bg:Destroy()
    bv:Destroy()
    plr.Character.Humanoid.PlatformStand = false
end

-- Keyboard control (P to increase speed, O to decrease speed)
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        -- Increase speed without limit
        speed = speed + 10  -- Increase speed by 10 units per press
    elseif input.KeyCode == Enum.KeyCode.O then
        -- Decrease speed, but do not go below 0
        speed = math.max(speed - 10, 0)
    elseif input.KeyCode == Enum.KeyCode.W then
        ctrl.f = 1
    elseif input.KeyCode == Enum.KeyCode.S then
        ctrl.b = -1
    elseif input.KeyCode == Enum.KeyCode.A then
        ctrl.l = -1
    elseif input.KeyCode == Enum.KeyCode.D then
        ctrl.r = 1
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then
        ctrl.f = 0
    elseif input.KeyCode == Enum.KeyCode.S then
        ctrl.b = 0
    elseif input.KeyCode == Enum.KeyCode.A then
        ctrl.l = 0
    elseif input.KeyCode == Enum.KeyCode.D then
        ctrl.r = 0
    end
    -- Don't reset speed to 0 when keys are released
end)

-- Rayfield Button Template
local Button = MiscTab:CreateButton({
    Name = "Fly Toggle - P to increase speed O to decrease speed",  -- Button name
    Info = "Press to toggle flying.",  -- Button description
    Interact = "Changable",  -- Interaction type
    Callback = function()
        -- Toggle flying state
        flying = not flying
        if flying then
            fly()  -- Start flying
            -- Notify the user on how to change speed when flying starts
            Rayfield:Notify({
                Title = "Speed Control",
                Content = "Press P to increase speed and O to decrease speed.",
                Duration = math.huge,  -- Keep the notification visible until flying is toggled off
                Image = 4483362458,  -- Default icon for notification
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("The user tapped Okay!")
                        end
                    },
                },
            })
        else
            -- Stop flying, reset the speed to 50, and destroy the notification
            speed = 50  -- Reset to starting speed
            Rayfield:Notify({
                Title = "Fly Disabled",
                Content = "Flying has been toggled off.",
                Duration = 4,  -- Short notification to confirm fly is off
                Image = 4483362458,  -- Default icon for notification
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
    end,
})


                                                                                                            --fly end
local TrollTab = Window:CreateTab("Trolls ☠️", nil)
local trollsSection = TrollTab:CreateSection("trolls", true)

-- Spin script


 -- start Bang script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variables for Bang animation
local bangAnimIdR15 = "rbxassetid://5918726674"
local bangAnimIdR6 = "rbxassetid://148840371"
local bangOffset = CFrame.new(0, 0, 1.1)
local bangLoop
local bangDied
local bang
local bangAnim

-- Utility function to get character root
local function getRoot(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
end

-- Function to toggle Bang animation
local function executeBang(targetPlayerName, speed, screenGui, frame)
    local localPlayer = Players.LocalPlayer
    local speaker = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoid = speaker:FindFirstChildWhichIsA("Humanoid")
    local targetPlayer = Players:FindFirstChild(targetPlayerName)

    if not targetPlayer or not targetPlayer.Character then
        warn("Target player not found or character does not exist!")
        return
    end

    -- Load Bang Animation
    bangAnim = Instance.new("Animation")
    bangAnim.AnimationId = humanoid.RigType == Enum.HumanoidRigType.R6 and bangAnimIdR6 or bangAnimIdR15
    bang = humanoid:LoadAnimation(bangAnim)
    bang:Play(0.1, 1, 1)
    bang:AdjustSpeed(speed or 3)

    -- Bang animation cleanup on death
    bangDied = humanoid.Died:Connect(function()
        bang:Stop()
        bangAnim:Destroy()
        bangDied:Disconnect()
        if bangLoop then
            bangLoop:Disconnect()
        end
    end)

    -- Follow target player
    bangLoop = RunService.Stepped:Connect(function()
        pcall(function()
            local targetRoot = getRoot(targetPlayer.Character)
            local speakerRoot = getRoot(speaker)
            if targetRoot and speakerRoot then
                speakerRoot.CFrame = targetRoot.CFrame * bangOffset
            end
        end)
    end)

    -- Hide UI after Bang
    screenGui:Destroy()
end

-- UI Setup for Bang Button
TrollTab:CreateButton({
    Name = "Bang UI",
    Callback = function()
        -- Create UI
        local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
        local Frame = Instance.new("Frame", ScreenGui)
        local TextBox = Instance.new("TextBox", Frame)
        local SpeedTextBox = Instance.new("TextBox", Frame) -- Speed input TextBox
        local BangButton = Instance.new("TextButton", Frame)
        local SpeedLabel = Instance.new("TextLabel", Frame)
        local TitleLabel = Instance.new("TextLabel", Frame) -- Title for UI

        -- UI Styling
        ScreenGui.ResetOnSpawn = false
        Frame.Size = UDim2.new(0, 350, 0, 400)
        Frame.Position = UDim2.new(0.5, -175, 0.5, -200)
        Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)  -- Dark background
        Frame.BorderSizePixel = 0
        Frame.BackgroundTransparency = 0.1

        -- Add UICorner for rounded corners
        local frameCorner = Instance.new("UICorner", Frame)
        frameCorner.CornerRadius = UDim.new(0, 10)

        -- Title Label (Professional header)
        TitleLabel.Size = UDim2.new(1, 0, 0, 40)
        TitleLabel.Position = UDim2.new(0, 0, 0, 0)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "Bang Animation - if name has uppercase U have to use uppercase"
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextSize = 24
        TitleLabel.TextScaled = true
        TitleLabel.Font = Enum.Font.GothamBold

        -- TextBox for Display Name (with placeholder and clean design)
        TextBox.Size = UDim2.new(0, 300, 0, 50)
        TextBox.Position = UDim2.new(0, 25, 0, 60)
        TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- Slightly darker background
        TextBox.Text = ""
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 18
        TextBox.ClearTextOnFocus = false
        TextBox.PlaceholderText = "Enter Display Name"
        TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        TextBox.Font = Enum.Font.Gotham

        -- Speed Label
        SpeedLabel.Size = UDim2.new(0, 300, 0, 30)
        SpeedLabel.Position = UDim2.new(0, 25, 0, 120)
        SpeedLabel.BackgroundTransparency = 1
        SpeedLabel.Text = "Animation Speed:"
        SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        SpeedLabel.TextSize = 18
        SpeedLabel.TextScaled = true
        SpeedLabel.Font = Enum.Font.Gotham

        -- Speed TextBox for speed input (professional look)
        SpeedTextBox.Size = UDim2.new(0, 300, 0, 30)
        SpeedTextBox.Position = UDim2.new(0, 25, 0, 160)
        SpeedTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        SpeedTextBox.Text = "3" -- Default speed
        SpeedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        SpeedTextBox.TextSize = 18
        SpeedTextBox.ClearTextOnFocus = false
        SpeedTextBox.PlaceholderText = "Enter Speed"
        SpeedTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        SpeedTextBox.Font = Enum.Font.Gotham

        -- Bang button styling (modern)
        BangButton.Size = UDim2.new(0, 300, 0, 50)
        BangButton.Position = UDim2.new(0, 25, 0, 220)
        BangButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)  -- Bright green for action button
        BangButton.Text = "Bang!"
        BangButton.TextSize = 20
        BangButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        BangButton.Font = Enum.Font.GothamBold

        -- Add UICorner to Bang Button for rounded corners
        local buttonCorner = Instance.new("UICorner", BangButton)
        buttonCorner.CornerRadius = UDim.new(0, 10)

        -- Button hover effects
        local function onHover(button)
            button.MouseEnter:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            end)
            button.MouseLeave:Connect(function()
                button.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            end)
        end
        onHover(BangButton)

        -- Smooth UI entry animation
        Frame:TweenPosition(UDim2.new(0.5, -175, 0.5, -200), "Out", "Elastic", 1, true)

        -- Bang button functionality
        BangButton.MouseButton1Click:Connect(function()
            local targetDisplayName = TextBox.Text
            local targetPlayer
            for _, player in pairs(Players:GetPlayers()) do
                if player.DisplayName == targetDisplayName then
                    targetPlayer = player
                    break
                end
            end

            local speed = tonumber(SpeedTextBox.Text)
            if not speed then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Invalid Input",
                    Text = "Please enter a valid number for speed.",
                    Duration = 5,
                })
                return
            end

            if targetPlayer then
                executeBang(targetPlayer.Name, speed, ScreenGui, Frame)
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Player Not Found",
                    Text = "No player found with that display name.",
                    Duration = 5,
                })
            end
        end)
    end,
})


                                                                                                                -- end bang script

local MusicTab = Window:CreateTab("Music! 🎶", nil) 

-- List of Sound IDs
local soundIDs = {
    "rbxassetid://7029011778",
    "rbxassetid://7024143472",
    "rbxassetid://5410084188",
    "rbxassetid://7028548115",
    "rbxassetid://5410083549",
    "rbxassetid://5410084938",
    "rbxassetid://7024028859",
    "rbxassetid://7029005367",
    "rbxassetid://5410083447",
    "rbxassetid://7023828725",
    "rbxassetid://5410082097",
    "rbxassetid://7028932563",
    "rbxassetid://7024233823",
    "rbxassetid://7029041793",
    "rbxassetid://5410083912",
    "rbxassetid://7029083554",
    "rbxassetid://1837879082",
    "rbxassetid://1845554017",
}

local playedSounds = {} -- To keep track of which sounds have been played
local currentSound = nil -- To store the current sound instance
local allSounds = {} -- Table to store all sound instances

-- Function to play a random sound from the list
local function playRandomSound()
    if #playedSounds == #soundIDs then
        -- If all sounds have been played, reset the played list
        playedSounds = {}
    end

    local randomIndex
    repeat
        randomIndex = math.random(1, #soundIDs)
    until not table.find(playedSounds, randomIndex)

    -- Mark this sound as played
    table.insert(playedSounds, randomIndex)

    -- Create a sound instance and play it
    if currentSound then
        -- Stop the previous sound if it's playing
        currentSound:Stop()
    end

    currentSound = Instance.new("Sound")
    currentSound.SoundId = soundIDs[randomIndex]
    currentSound.Parent = game.Workspace
    currentSound:Play()

    -- Store the current sound in the allSounds table
    table.insert(allSounds, currentSound)

    -- Automatically play the next sound when the current one finishes
    currentSound.Ended:Connect(function()
        playRandomSound()
    end)
end

-- Function to skip the current song
local function skipSong()
    if currentSound then
        -- Stop the current sound immediately
        currentSound:Stop()
    end

    -- Play the next song
    playRandomSound()
end

-- Function to stop all sounds
local function stopAllSounds()
    -- Iterate through all sound instances and stop them
    for _, sound in ipairs(allSounds) do
        sound:Stop()
    end

    -- Clear the allSounds table
    allSounds = {}

    -- Stop the current sound
    if currentSound then
        currentSound:Stop()
        currentSound = nil
    end
end

-- Create the Play Random Sound button
MusicTab:CreateButton({ 
    Name = "Play Random Song",
    Info = "Plays a random sound and loops through all until done.",
    Interact = 'Changable',
    Callback = function()
        playRandomSound()
    end,
})

-- Create the Skip Song button
MusicTab:CreateButton({
    Name = "Skip Song",
    Info = "Skips the current song and plays the next one.",
    Interact = 'Changable',
    Callback = function()
        skipSong()
    end,
})

-- Create the Stop All Sounds button
MusicTab:CreateButton({
    Name = "Stop All Songs",
    Info = "Stops all currently playing sounds.",
    Interact = 'Changable',
    Callback = function()
        stopAllSounds()
    end,
})

                                                                                                                -- end music

                                                                                                                -- RejoinServer
local ServersTab = Window:CreateTab("Server💻", nil)
local ServerSection = ServersTab:CreateSection("Server Actions", true)

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local PlaceId = game.PlaceId  -- Gets the current place ID
local JobId = game.JobId  -- Gets the current job ID

-- Rejoin button
ServersTab:CreateButton({
    Name = "Rejoin Game", -- Button name
    Callback = function()
        if #Players:GetPlayers() <= 1 then
            -- If there is only one player (you), kick and rejoin
            Players.LocalPlayer:Kick("\nRejoining...")
            wait(1)  -- Wait for a brief moment before teleporting
            TeleportService:Teleport(PlaceId, Players.LocalPlayer)
        else
            -- If there are other players, teleport to the current instance
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
        end
    end,
})
                                                                                                    --end rejoin
                                                                                                    --serverhop


-- Define the PlaceId and JobId
local PlaceId, JobId = game.PlaceId, game.JobId

-- Try to get the httprequest function from various sources (Synapse X, Fluxus, etc.)
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

-- Server Hop Function
local function serverHop()
    -- Check if httprequest is available or use a fallback
    if httprequest then
        -- Using httprequest if available
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
            -- Teleport to a random available server
            local serverToJoin = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(PlaceId, serverToJoin, Players.LocalPlayer)
        else
            -- No servers found
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
        -- Use HttpService fallback for request
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
                -- Teleport to a random available server
                local serverToJoin = servers[math.random(1, #servers)]
                TeleportService:TeleportToPlaceInstance(PlaceId, serverToJoin, Players.LocalPlayer)
            else
                -- No servers found
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
            -- Fallback if GetAsync fails
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

-- Create a Rayfield button for server hopping
ServersTab:CreateButton({
    Name = "Server Hop", -- Button name
    Callback = function()
        -- Call the server hop function when button is clicked
        serverHop()
    end,
})

                                                                                                                    --end ServerHop

local CreditsTab = Window:CreateTab("ScriptWriter", nil)
local OwnerSection = CreditsTab:CreateSection("ScriptWriter", true)
local Label = CreditsTab:CreateLabel("Owner - PrismX",SectionParent)

