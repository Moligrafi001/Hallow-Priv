local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | South Bronx 👊",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

local Main = Window:CreateTab("Main", nil) -- Title, Image

local Section = Main:CreateSection("Other")

local PlayerTab = Window:CreateTab("Player", nil) -- Title, Image

local Section = PlayerTab:CreateSection("Powers")

local Toggle = Main:CreateToggle({
    Name = "ESP Toggle",
    CurrentValue = false,
    Flag = "ToggleESP",
    Callback = function(Value)
        ESPEnabled = Value
        if ESPEnabled then
            EnableESP()
        else
            DisableESP()
        end
    end,
})

-- Variables for ESP
local ESPEnabled = false
local ESPObjects = {}

-- Function to create ESP for a player
local function CreateESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        -- Create box ESP
        local highlight = Instance.new("BoxHandleAdornment")
        highlight.Name = "ESPBox"
        highlight.Adornee = player.Character.HumanoidRootPart
        highlight.AlwaysOnTop = true
        highlight.ZIndex = 5
        highlight.Size = player.Character.HumanoidRootPart.Size + Vector3.new(2, 2, 2)
        highlight.Color3 = Color3.fromRGB(255, 0, 0)
        highlight.Transparency = 0.5
        highlight.Parent = player.Character

        -- Create name label
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "ESPName"
        billboardGui.Adornee = player.Character.HumanoidRootPart
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 3, 0)
        billboardGui.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboardGui
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextStrokeTransparency = 0
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 14

        billboardGui.Parent = player.Character

        -- Create glow effect
        local highlightEffect = Instance.new("Highlight")
        highlightEffect.Name = "ESPGlow"
        highlightEffect.Adornee = player.Character
        highlightEffect.FillColor = Color3.fromRGB(255, 0, 0)
        highlightEffect.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlightEffect.FillTransparency = 0.5
        highlightEffect.OutlineTransparency = 0
        highlightEffect.Parent = player.Character

        ESPObjects[player] = {highlight = highlight, nameTag = billboardGui, glow = highlightEffect}
    end
end

-- Function to remove ESP for a player
local function RemoveESP(player)
    if ESPObjects[player] then
        if ESPObjects[player].highlight then
            ESPObjects[player].highlight:Destroy()
        end
        if ESPObjects[player].nameTag then
            ESPObjects[player].nameTag:Destroy()
        end
        if ESPObjects[player].glow then
            ESPObjects[player].glow:Destroy()
        end
        ESPObjects[player] = nil
    end
end

-- Function to enable ESP
function EnableESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            CreateESP(player)
        end
    end

    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            if ESPEnabled then
                CreateESP(player)
            end
        end)
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        RemoveESP(player)
    end)
end

-- Function to disable ESP
function DisableESP()
    for player, espData in pairs(ESPObjects) do
        if espData.highlight then
            espData.highlight:Destroy()
        end
        if espData.nameTag then
            espData.nameTag:Destroy()
        end
        if espData.glow then
            espData.glow:Destroy()
        end
        ESPObjects[player] = nil
    end
end

-- Ultra-Enhanced Noclip Script with Robust Functionality and Debugging

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local noclipConnection
local noclipEnabled = false

-- Advanced notification function with animations
local function CreateAdvancedNotification(title, text)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AdvancedNotification"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 120)
    frame.Position = UDim2.new(0.5, -175, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.Parent = frame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.7, 0)
    textLabel.Position = UDim2.new(0, 0, 0.3, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 16
    textLabel.TextWrapped = true
    textLabel.Parent = frame

    -- Slide in animation
    frame.Position = UDim2.new(0.5, -175, -0.2, 0)
    frame:TweenPosition(UDim2.new(0.5, -175, 0.1, 0), "Out", "Bounce", 0.5, true)

    -- Fade out after 3 seconds
    task.delay(3, function()
        for i = 0, 1, 0.05 do
            frame.BackgroundTransparency = i
            titleLabel.TextTransparency = i
            textLabel.TextTransparency = i
            task.wait(0.05)
        end
        screenGui:Destroy()
    end)
end


-- Variables
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local aimbotEnabled = false
local aimbotRange = 1000 -- Maximum range for targeting
local aimbotSmoothness = 0.2 -- Smoothness factor for aiming
local lockedTarget = nil -- To store the locked target

-- Advanced notification function
local function CreateAdvancedNotification(title, text)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AdvancedNotification"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 120)
    frame.Position = UDim2.new(0.5, -175, 0.1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.Parent = screenGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.Parent = frame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.7, 0)
    textLabel.Position = UDim2.new(0, 0, 0.3, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 16
    textLabel.TextWrapped = true
    textLabel.Parent = frame

    frame.Position = UDim2.new(0.5, -175, -0.2, 0)
    frame:TweenPosition(UDim2.new(0.5, -175, 0.1, 0), "Out", "Bounce", 0.5, true)

    task.delay(3, function()
        for i = 0, 1, 0.05 do
            frame.BackgroundTransparency = i
            titleLabel.TextTransparency = i
            textLabel.TextTransparency = i
            task.wait(0.05)
        end
        screenGui:Destroy()
    end)
end

-- Find the closest target within range (only if no target is locked)
local function FindClosestTarget()
    local closestTarget = nil
    local shortestDistance = aimbotRange

    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            local targetHead = targetPlayer.Character.Head
            local distance = (targetHead.Position - camera.CFrame.Position).Magnitude

            if distance < shortestDistance then
                shortestDistance = distance
                closestTarget = targetHead
            end
        end
    end

    return closestTarget
end

-- Smooth camera movement towards target
local function SmoothAim(targetPosition)
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    camera.CFrame = currentCFrame:Lerp(targetCFrame, aimbotSmoothness)

    -- Sync player movement with camera direction
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, Vector3.new(targetPosition.X, humanoidRootPart.Position.Y, targetPosition.Z))
    end
end

-- Function to toggle the aimbot
local function ToggleAimbot(state)
    aimbotEnabled = state

    if aimbotEnabled then
        CreateAdvancedNotification("Aimbot Enabled", "The camera will now lock onto the closest target.")

        -- Start locking onto a target
        lockedTarget = FindClosestTarget()

        RunService.RenderStepped:Connect(function()
            if aimbotEnabled and lockedTarget then
                if lockedTarget.Parent and lockedTarget:IsA("BasePart") then
                    SmoothAim(lockedTarget.Position)
                else
                    lockedTarget = nil -- Reset target if it's no longer valid
                end
            end
        end)
    else
        CreateAdvancedNotification("Aimbot Disabled", "The camera will no longer lock onto targets.")
        lockedTarget = nil -- Clear the target on disable
    end
end

-- Keybind to toggle the aimbot
local Keybind = Main:CreateKeybind({
    Name = "Toggle Aimbot",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Flag = "AimbotKeybind",
    Callback = function()
        ToggleAimbot(not aimbotEnabled)
    end,
})

local Button = PlayerTab:CreateButton({
   Name = "Fps Booster/ClearLag",
   Callback = function()
   -- FPS Booster Script for Admin Settings
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local fpsBoostEnabled = false

local function ToggleFPSBoost()
    fpsBoostEnabled = not fpsBoostEnabled

    if fpsBoostEnabled then
        print("FPS Boost Enabled")
        
        -- Save current settings to restore later
        local originalSettings = {
            Ambient = Lighting.Ambient,
            OutdoorAmbient = Lighting.OutdoorAmbient,
            Brightness = Lighting.Brightness,
            TimeOfDay = Lighting.TimeOfDay,
        }

        -- Apply FPS-optimized settings
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
        Lighting.Brightness = 0
        Lighting.TimeOfDay = "00:00:00"
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e9

        -- Lower the quality of player meshes (like accessories)
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= player and v.Character then
                for _, obj in pairs(v.Character:GetDescendants()) do
                    if obj:IsA("MeshPart") or obj:IsA("BasePart") then
                        obj.Material = Enum.Material.SmoothPlastic
                    end
                end
            end
        end

        -- Disable particle effects
        for _, particle in pairs(workspace:GetDescendants()) do
            if particle:IsA("ParticleEmitter") or particle:IsA("Trail") then
                particle.Enabled = false
            end
        end

        -- Disable textures
        for _, tex in pairs(workspace:GetDescendants()) do
            if tex:IsA("Texture") then
                tex:Destroy()
            end
        end
    else
        print("FPS Boost Disabled")
        -- Restore original settings
        Lighting.Ambient = Color3.new(127, 127, 127)
        Lighting.OutdoorAmbient = Color3.new(127, 127, 127)
        Lighting.Brightness = 2
        Lighting.TimeOfDay = "12:00:00"
        Lighting.GlobalShadows = true
    end
end
    end,
})

-- New Script for Toggle Godmode

-- Function to toggle Godmode
local function ToggleGodmode(isEnabled)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")

    if humanoid then
        if isEnabled then
            humanoid.MaxHealth = math.huge
            humanoid.Health = humanoid.MaxHealth
            print("Godmode enabled")

            -- Heal instantly upon taking damage
            humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end)
        else
            humanoid.MaxHealth = 100
            humanoid.Health = humanoid.MaxHealth
            print("Godmode disabled")
        end
    else
        print("Humanoid not found. Cannot toggle Godmode.")
    end
end

-- Create the toggle button for Godmode
local Toggle = Main:CreateToggle({
   Name = "Godmode Toggle",
   CurrentValue = false,
   Flag = "ToggleGodmode", -- A unique identifier for this toggle
   Callback = function(Value)
       ToggleGodmode(Value)
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

