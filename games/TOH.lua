local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create a new Rayfield UI window
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Tower Of Hell",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

local isAntiKickEnabled = false

-- Function to hook kick prevention
local function enableAntiKick()

    -- Safely get the metatable
    local success, reg = pcall(function() return debug.getmetatable(game) end)

    if success and reg then
        for i, Function in next, reg do
            if type(Function) == 'function' then
                local info = getinfo(Function)

                if info.name == 'kick' then
                    if (hookfunction(info.func, function(...)end)) then
                        print('Successfully hooked kick')
                    else
                        print('Failed to hook kick')
                    end
                end
            end
        end
    else
        print('Failed to get metatable')
        return
    end

    local playerscripts = game:GetService'Players'.LocalPlayer.PlayerScripts

    local script1 = playerscripts.LocalScript
    local script2 = playerscripts.LocalScript2

    local script1signal = script1.Changed
    local script2signal = script2.Changed

    for i, connection in next, getconnections(script1signal) do
        connection:Disable()
    end
    for i, connection in next, getconnections(script2signal) do
        connection:Disable()
    end

    script1:Destroy()
    script2:Destroy()

    print("[Anti-Kick] Fully Enabled! 🚀")
end

-- Home Tab
local HomeTab = Window:CreateTab("🏠 Home", nil)
local MainSection = HomeTab:CreateSection("⚠️ENABLE THIS BEFORE ANYTHING⚠️", true)

HomeTab:CreateToggle({
    Name = "Anti-Kick",
    Info = "Prevents the game from kicking you.",
    CurrentValue = false,
    Flag = "AntiKickToggle",
    Callback = function(Value)
        isAntiKickEnabled = Value  -- Set isAntiKickEnabled to the toggle state

        if Value then
            -- Enable Anti-Kick
            enableAntiKick()

            -- Notify the user
            pcall(function()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Anti-Kick Enabled",
                    Text = "You are now protected from kicks.",
                    Duration = 5,
                })
            end)
        else
            -- Notify that Anti-Kick is disabled
            pcall(function()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Anti-Kick Disabled",
                    Text = "You are no longer protected from kicks.",
                    Duration = 5,
                })
            end)
        end
    end
})


local MainSection = HomeTab:CreateSection("Main", true)

-- WalkSpeed Slider (Only works if Anti-Kick is enabled)
HomeTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 400},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        if not isAntiKickEnabled then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error",
                Text = "You need to enable Anti-Kick first!",
                Duration = 5,
            })
            return
        end
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

-- JumpPower Slider (Only works if Anti-Kick is enabled)
HomeTab:CreateSlider({
    Name = "JumpPower",
    Range = {0, 500},
    Increment = 1,
    Suffix = "Jump",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        if not isAntiKickEnabled then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error",
                Text = "You need to enable Anti-Kick first!",
                Duration = 5,
            })
            return
        end
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

HomeTab:CreateButton({
    Name = "Reset WalkSpeed/JumpPower",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
})


-- GodMode (Only works if Anti-Kick is enabled)
HomeTab:CreateToggle({
    Name = "GodMode",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(Value)
        if Value then
            -- Enable GodMode
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local protectionConnections = {} -- Store connections for cleanup

            -- Function to prevent health from dropping
            local function preventDeath()
                humanoid.HealthChanged:Connect(function(health)
                    if health < humanoid.MaxHealth then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end)
            end

            -- Apply protection to kill bricks
            local function detectKillBricks()
                for _, part in pairs(workspace:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name:lower():find("kill") then
                        protectionConnections[part] = part.Touched:Connect(function(hit)
                            if hit.Parent == character then
                                humanoid.Health = humanoid.MaxHealth
                            end
                        end)
                    end
                end
            end

            -- Monitor workspace for new hazards
            local workspaceConnection = workspace.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("BasePart") and descendant.Name:lower():find("kill") then
                    protectionConnections[descendant] = descendant.Touched:Connect(function(hit)
                        if hit.Parent == character then
                            humanoid.Health = humanoid.MaxHealth
                        end
                    end)
                end
            end)

            -- Start protection
            preventDeath()
            detectKillBricks()

            -- Store cleanup connections in _G for disabling
            _G.godModeConnections = protectionConnections
            _G.godModeWorkspaceConnection = workspaceConnection

            game.StarterGui:SetCore("SendNotification", {
                Title = "GodMode Enabled",
                Text = "You are now invincible.",
                Duration = 5,
            })
        else
            -- Disable GodMode
            if _G.godModeConnections then
                for _, connection in pairs(_G.godModeConnections) do
                    connection:Disconnect()
                end
                _G.godModeConnections = nil
            end
            if _G.godModeWorkspaceConnection then
                _G.godModeWorkspaceConnection:Disconnect()
                _G.godModeWorkspaceConnection = nil
            end

            game.StarterGui:SetCore("SendNotification", {
                Title = "GodMode Disabled",
                Text = "You are no longer invincible.",
                Duration = 5,
            })
        end
    end,
})


local teleportSection = HomeTab:CreateSection("teleport stuff", true)

-- Teleport tool (Only works if Anti-Kick is enabled)
HomeTab:CreateButton({
    Name = "Teleport Tool",
    Callback = function()
        if not isAntiKickEnabled then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error",
                Text = "You need to enable Anti-Kick first!",
                Duration = 5,
            })
            return
        end
        
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

local NoclipSection = HomeTab:CreateSection("Noclip actions", true)

                                                                                                                -- Variables to manage NoClip state
-- Variables to manage NoClip state
local noclipActive = false
local player = game.Players.LocalPlayer

-- Function to toggle NoClip
local function toggleNoClip()
    noclipActive = not noclipActive -- Toggle NoClip state

    if noclipActive then
        -- Enable NoClip
        local function disableCollisions()
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        -- Initial NoClip activation
        disableCollisions()

        -- Continuous NoClip enforcement
        local noclipConnection
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if noclipActive then
                disableCollisions()
            else
                noclipConnection:Disconnect()
            end
        end)
    else
        -- Disable NoClip: Restore Collisions
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end

        -- Reset Humanoid properties
        if player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.PlatformStand = false
        end
    end
end

-- Handle character respawn to reapply NoClip logic
player.CharacterAdded:Connect(function(newCharacter)
    player.Character = newCharacter
    if noclipActive then
        -- Reapply NoClip after respawn
        toggleNoClip()
    end
end)

-- Buttons to toggle NoClip and Clip
HomeTab:CreateButton({
    Name = "Toggle NoClip",
    Callback = toggleNoClip,
})

HomeTab:CreateButton({
    Name = "Force Clip! (If toggle not working after death/respawn)",
    Callback = function()
        noclipActive = false

        -- Restore Collisions
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end

        -- Reset Humanoid properties
        if player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            humanoid.PlatformStand = false
        end
    end,
})

HomeTab:CreateButton({
   Name = "Anti-Lag",
   Callback = function()
       loadstring(game:HttpGet('https://pastebin.com/raw/eVHmQQvQ'))()
    end
})

HomeTab:CreateButton({
   Name = "Anti-AFK",
   Callback = function()
      local vu = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
         vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
         wait(1)
         vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
      end)
   end
})

                                                                                                            --Noclip end

local MiscTab = Window:CreateTab("Misc🎲", nil)
local ItemsSection = MiscTab:CreateSection("Items", true)

local Button = MiscTab:CreateButton({
   Name = "Instant Win🏆",
   Callback = function()
   local endzone = game.Workspace.tower.sections.finish.FinishGlow.CFrame
 
    local player = game.Players.LocalPlayer.Character
    player.HumanoidRootPart.CFrame = endzone
   end,
})


MiscTab:CreateButton({
    Name = "Get All Items!!",
    Callback = function()
        for _, e in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
            if e:IsA("Tool") then
                e:Destroy()
            end
        end
        
        wait()
        
        for _, v in pairs(game.ReplicatedStorage.Gear:GetDescendants()) do
            if v:IsA("Tool") then
                local CloneThings = v:Clone()
                wait()
                CloneThings.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end
})


getgenv().Boolean = false

                        
MiscTab:CreateToggle({
    Name = "AutoFarm",
    Info = "AutoFinishes for you",
    CurrentValue = false,
    Flag = "Autofarmtog",
    Callback = function(Value)
        getgenv().Boolean = Value
        
        if Value then -- if Value == true then
            name() 
        end
    end
})
function name()
spawn(function()
while getgenv().Boolean == true do
local endzone = game.Workspace.tower.sections.finish.FinishGlow.CFrame
 
local player = game.Players.LocalPlayer.Character
player.HumanoidRootPart.CFrame = endzone
wait()
end
end)
end

local CheckSection = MiscTab:CreateSection("Checkpoint✅🏁", true)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Variables
local localPlayer = Players.LocalPlayer
local humanoidRootPart = nil
local checkpoint = nil
local teleportAllowed = false
local lastValidPosition = nil

-- Function to monitor and prevent game teleports
local function preventGameTeleport()
    RunService.Heartbeat:Connect(function()
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart = localPlayer.Character.HumanoidRootPart
        end

        if humanoidRootPart then
            -- Store the last valid position
            if not teleportAllowed then
                lastValidPosition = humanoidRootPart.Position
            end

            -- Enforce the last valid position if teleportation is not allowed
            if humanoidRootPart.Position ~= lastValidPosition and not teleportAllowed then
                humanoidRootPart.CFrame = CFrame.new(lastValidPosition)
            end
        end
    end)
end

-- Function to create a checkpoint
local function createCheckpoint()
    if checkpoint then checkpoint:Destroy() end

    checkpoint = Instance.new("Part")
    checkpoint.Size = Vector3.new(4, 1, 4)
    checkpoint.Position = humanoidRootPart.Position + Vector3.new(0, -3, 0)
    checkpoint.Anchored = true
    checkpoint.CanCollide = false
    checkpoint.BrickColor = BrickColor.new("Bright yellow")
    checkpoint.Material = Enum.Material.Neon
    checkpoint.Parent = workspace

    Rayfield:Notify({
        Title = "Checkpoint Set",
        Content = "Your checkpoint has been placed.",
        Duration = 5,
        Image = 4483362458,
    })
end

-- Function to teleport to the checkpoint
local function teleportToCheckpoint()
    if not checkpoint then
        Rayfield:Notify({
            Title = "No Checkpoint",
            Content = "You must place a checkpoint first.",
            Duration = 5,
            Image = 4483362458,
        })
        return
    end

    -- Temporarily allow teleportation
    teleportAllowed = true
    humanoidRootPart.CFrame = CFrame.new(checkpoint.Position + Vector3.new(0, 3, 0)) -- Teleport above the checkpoint
    task.wait(0.2) -- Small delay to stabilize the teleport
    teleportAllowed = false

    Rayfield:Notify({
        Title = "Teleported",
        Content = "You have been teleported to your checkpoint.",
        Duration = 5,
        Image = 4483362458,
    })
end

-- Create buttons
MiscTab:CreateButton({
    Name = "Set Checkpoint",
    Callback = createCheckpoint,
})

MiscTab:CreateButton({
    Name = "Teleport to Checkpoint",
    Callback = teleportToCheckpoint,
})

-- Initialize the teleport block
preventGameTeleport()


local TrollTab = Window:CreateTab("Trolls ☠️", nil)
local trollsSection = TrollTab:CreateSection("trolls", true)

                                                                                                                    -- Spin script

local Player = game:GetService("Players").LocalPlayer

-- Create a UI for spin speed input
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local SpinButton = Instance.new("TextButton")
local SpinActive = false
local Torque

ScreenGui.Name = "SpinUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Visible = false -- Initially hide the Frame

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
TextBox.Size = UDim2.new(1, 0, 0, 30)
TextBox.PlaceholderText = "Enter spin speed (10, 20, etc.)"

SpinButton.Parent = Frame
SpinButton.BackgroundColor3 = Color3.new(0, 1, 0)
SpinButton.Position = UDim2.new(0, 0, 0.35, 0)
SpinButton.Size = UDim2.new(1, 0, 0, 30)
SpinButton.Text = "Set Spin Speed"

local function createTorque()
    local humanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")

    if Torque then
        Torque:Destroy() -- Remove previous torque if it exists
    end

    Torque = Instance.new("Torque", humanoidRootPart)
    Torque.RelativeTo = Enum.ActuatorRelativeTo.Attachment0

    -- Create an attachment at the top of the HumanoidRootPart for torque application
    local attachment0 = Instance.new("Attachment", humanoidRootPart)
    attachment0.CFrame = CFrame.new(humanoidRootPart.Position + Vector3.new(0, humanoidRootPart.Size.Y / 2, 0)) * CFrame.Angles(math.rad(90), 0, 0)

    Torque.Attachment0 = attachment0
end

TrollTab:CreateToggle({
    Name = "Spin",
    CurrentValue = false,
    Flag = "Spin",
    Callback = function(Value)
        if Value then
            Frame.Visible = true  -- Show the Frame (UI) when toggled on
        else
            Frame.Visible = false -- Hide the Frame (UI) when toggled off
            if Torque then
                Torque:Destroy() -- Stop torque
                Torque = nil
                    print("off")
            end
            SpinActive = false
        end
    end,
})

Player.CharacterAdded:Connect(function(character)
    Player.Character = character
end)

SpinButton.MouseButton1Click:Connect(function()
    local speedInput = tonumber(TextBox.Text) -- Get the input number

    if speedInput and speedInput > 0 then
        createTorque() -- Create the torque
        Torque.Torque = Vector3.new(0, 0, speedInput * 100) -- Set torque based on input value
        SpinActive = true
        Frame.Visible = false -- Hide the UI
    else
        warn("Please enter a valid positive number")
    end
end)

-- Detect player touch and apply fling force
local function flingTouchedPlayer(otherPart)
    local otherCharacter = otherPart.Parent
    if otherCharacter and otherCharacter:FindFirstChild("Humanoid") then
        local humanoidRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local force = Instance.new("BodyVelocity")
            force.Velocity = (humanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Unit * 100
            force.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            force.Parent = humanoidRootPart

            task.delay(0.2, function()
                force:Destroy()
            end)
        end
    end
end

Player.CharacterAdded:Connect(function(character)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.Touched:Connect(flingTouchedPlayer)
end)

if Player.Character then
    local humanoidRootPart = Player.Character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        humanoidRootPart.Touched:Connect(flingTouchedPlayer)
    end
end

                                                                                                        -- end spin script

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
    Name = "Play Random Sound",
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
    Name = "Stop All Sounds",
    Info = "Stops all currently playing sounds.",
    Interact = 'Changable',
    Callback = function()
        stopAllSounds()
    end,
})

                                                                                                                -- end music

    -- Assuming Rayfield and the necessary libraries are already loaded
local ToolsTab = Window:CreateTab("⚙️ Tools", nil) -- Replace "Tools" with your desired tab name
local PartsSection = ToolsTab:CreateSection("Parts", true)
                                                                                                                            -- moving part manager
-- Define the function to stop all moving parts
local function stopMovingParts()
    -- Loop through all descendants in the game
    for _, part in pairs(workspace:GetDescendants()) do
        -- Check if the object is a BasePart
        if part:IsA("BasePart") then
            -- Stop its velocity
            part.Velocity = Vector3.zero
            part.RotVelocity = Vector3.zero
            
            -- Destroy any BodyMovers (like BodyVelocity or BodyGyro) that might be causing movement
            for _, child in pairs(part:GetChildren()) do
                if child:IsA("BodyMover") then
                    child:Destroy()
                end
            end
        end

        -- Disable any constraints that might cause motion
        if part:IsA("HingeConstraint") or part:IsA("Motor") or part:IsA("Motor6D") then
            part.Enabled = false
        end
    end

    -- Notify the user that moving parts have been stopped
    Rayfield:Notify({
        Title = "Parts Stopped",
        Content = "All moving parts have been stopped.",
        Duration = 6.5,
        Image = 4483362458,
        Actions = {
            Ignore = {
                Name = "Okay!",
                Callback = function()
                    print("Moving parts were stopped.")
                end
            },
        },
    })
end

-- Create the button to stop moving parts
ToolsTab:CreateButton({
    Name = "Stop Moving Parts (⚠️CAN NOT UNDO⚠️ unless u rejoin)",
    Info = "Stops all moving parts in the game.",
    Interact = 'Button',
    Callback = function()
        stopMovingParts()
    end,
})



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
            Players.LocalPlayer:Kick("Rejoining...")
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

local CreditsTab = Window:CreateTab("Credits", nil)
local OwnerSection = CreditsTab:CreateSection("Owner", true)
local Label = CreditsTab:CreateLabel("Owner - PrismX",SectionParent)

