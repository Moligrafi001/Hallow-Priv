-- Load the Rayfield UI library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create a new Rayfield UI window
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Masters DCO👑",
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi & PrismX",
    Theme = "Amethyst"
})


-- Teleporting delay
_G.delay = 0.3 

-- Mode for teleportation (can be 'moveto' or 'cframe')
_G.mode = "moveto" 


-- Path to checkpoints folder
_G.pathtocheckpoints = game:GetService("Workspace").Checkpoints

-- Get the player's current stage from leaderstats
_G.currentCheckpoint = game.Players.LocalPlayer.leaderstats.Stage.Value

-- List of specific checkpoints to move to (21, 41, 61, etc.)
local checkpointsToTeleport = {21, 41, 61, 81, 101, 121, 141, 161, 181, 201, 221, 241, 261, 281, 301, 321, 341, 361, 381}

local WalkSpeedText = 16
local JumpPowerText = 50
_G.SetWalkSpeed = false
_G.SetJumpPower = false
_G.InfJump = false
_G.NoClip = false

-- Functions
local function SetWalkSpeed()
    while _G.SetWalkSpeed == true do
        if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
        end
        wait(0.01)
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

local teleportingActive = false 

local function moveToNextCheckpoint()
    for _, checkpointNum in ipairs(checkpointsToTeleport) do
        if checkpointNum < _G.currentCheckpoint then
            continue
        end
        
        if not teleportingActive then break end 
        wait(_G.delay)
        
        local nextCheckpoint = _G.pathtocheckpoints:FindFirstChild(tostring(checkpointNum))
        
        if nextCheckpoint and nextCheckpoint:IsA("Model") and nextCheckpoint:FindFirstChild("Part") then
            local part = nextCheckpoint.Part 
            
            if _G.mode == "moveto" then
                game.Players.LocalPlayer.Character:MoveTo(part.Position)
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame
            end
            
            _G.currentCheckpoint = checkpointNum
        else
            warn("Checkpoint ("..checkpointNum..") or its part not found!")
        end
    end
end

-- Create a function to toggle teleportation on and off
local function toggleTeleportation()
    teleportingActive = not teleportingActive  
    if teleportingActive then
        moveToNextCheckpoint() 
    else
        print("Teleportation stopped.")  
    end
end

local function moveToNextCheckpoint()
    while true do
        wait(_G.delay)
        local nextCheckpointNum = _G.currentCheckpoint + 1
        local nextCheckpoint = _G.pathtocheckpoints:FindFirstChild(tostring(nextCheckpointNum))
        
        if nextCheckpoint and nextCheckpoint:IsA("Model") and nextCheckpoint:FindFirstChild("Part") then
            local part = nextCheckpoint:FindFirstChild("Part")
            
            if _G.mode == "moveto" then
                game.Players.LocalPlayer.Character:MoveTo(part.Position)
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame
            end
            
            _G.currentCheckpoint = nextCheckpointNum
            break
        else
            warn("Next checkpoint ("..nextCheckpointNum..") or its part not found!")
        end
    end
end


local Menu = Window:CreateTab("Main", "badge-check")
local Section = Menu:CreateSection("Game things")
local divider = Menu:CreateDivider(true)

local Button = Menu:CreateButton({
   Name = "OP Auto Win!!!",
   Interact = 'Changable',
   Callback = function()
       toggleTeleportation()
   end,
})
local divider = Menu:CreateDivider(true)

Menu:CreateButton({
   Name = "Skip Stage",
   Callback = function()
      _G.currentCheckpoint = game.Players.LocalPlayer.leaderstats.Stage.Value
      
      local function moveToNextCheckpoint()
         while true do
            wait(_G.delay)
            local nextCheckpointNum = _G.currentCheckpoint + 1
            local nextCheckpoint = _G.pathtocheckpoints:FindFirstChild(tostring(nextCheckpointNum))
            
            if nextCheckpoint and nextCheckpoint:IsA("Model") and nextCheckpoint:FindFirstChild("Part") then
               local part = nextCheckpoint.Part
               
               if _G.mode == "moveto" then
                  game.Players.LocalPlayer.Character:MoveTo(part.Position)
               else
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = part.CFrame
               end
               
               _G.currentCheckpoint = nextCheckpointNum
               break
            else
               Rayfield:Notify({
                  Title = "Checkpoint Not Found",
                  Content = "Next checkpoint (" .. nextCheckpointNum .. ") or its part not found!",
                  Duration = 3,
                  Image = 4483362458,
                  Actions = {
                     Ignore = {
                        Name = "Okay",
                        Callback = function() end
                     },
                  },
               })
            end
         end
      end
      
      moveToNextCheckpoint()
   end,
})

local divider = Menu:CreateDivider(true)

Menu:CreateButton({
    Name = "Teleport Tool",
    Callback = function()       
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        -- Create the Teleport Tool
        local tool = Instance.new("Tool")
        tool.Name = "TeleportTool"
        tool.RequiresHandle = false
        tool.Parent = player.Backpack 

        local function onActivated()
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then
                return
            end

            local mouse = player:GetMouse()
            local position = mouse.Hit.p

            character.HumanoidRootPart.CFrame = CFrame.new(position)
        end

        tool.Activated:Connect(onActivated)

        print("Teleport Tool created. Equip it and click anywhere to teleport.")
    end,
})

local divider = Menu:CreateDivider(true)
local Player = Window:CreateTab("Player", "person-standing")
local Section = Player:CreateSection("Player stuff")

-- Create an input field for walk speed
local Input = Player:CreateInput({
    Name = "Player Walk Speed",
    CurrentValue = "16",
    Flag = "WalkSpeedInput",
    PlaceholderText = "Default Walk Speed = 16",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        WalkSpeedText = tonumber(Text)
    end,
})

-- Create a toggle for walk speed
local Toggle = Player:CreateToggle({
    Name = "Toggle Walk Speed",
    CurrentValue = false,
    Flag = "WalkSpeedToggle",
    Callback = function(Value)
        _G.SetWalkSpeed = Value
        if Value then
            SetWalkSpeed()
        end
    end,
})

-- Create a toggle for no clip
local Toggle = Player:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Flag = "NoClipToggle",
    Callback = function(Value)
        _G.NoClip = Value
        if Value then
            NoClip()
        end
    end,
})

-- Create a section for jump
local Section = Player:CreateSection("Jump")

-- Create an input field for jump power
local Input = Player:CreateInput({
    Name = "Player Jump Power",
    CurrentValue = "50",
    Flag = "JumpPowerInput",
    PlaceholderText = "Default Jump Power = 50",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        JumpPowerText = tonumber(Text)
    end,
})

-- Create a toggle for jump power
local Toggle = Player:CreateToggle({
    Name = "Toggle Jump Power",
    CurrentValue = false,
    Flag = "JumpPowerToggle",
    Callback = function(Value)
        _G.SetJumpPower = Value
        if Value then
            SetJumpPower()
        end
    end,
})

-- Create a toggle for inf jump
local Toggle = Player:CreateToggle({
    Name = "Inf Jump",
    CurrentValue = false,
    Flag = "InfJumpToggle",
    Callback = function(Value)
        _G.InfJump = Value
        if Value then
            InfJump()
        end
    end,
})
