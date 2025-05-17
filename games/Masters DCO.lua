local LoadingGUI = Instance.new("ScreenGui")
LoadingGUI.Name = "LoadingScreen"
LoadingGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingGUI.DisplayOrder = 2147483647 -- Maximum possible value
LoadingGUI.IgnoreGuiInset = true
LoadingGUI.Parent = game:GetService("CoreGui")


-- Loading screen container
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Container.BorderSizePixel = 0
Container.Parent = LoadingGUI
Container.BackgroundTransparency = 0.8

-- Loading content frame
local LoadingContent = Instance.new("Frame")
LoadingContent.Size = UDim2.new(0, 400, 0, 300)
LoadingContent.Position = UDim2.new(0.5, -200, 0.5, -150)
LoadingContent.BackgroundTransparency = 1
LoadingContent.Parent = Container

-- Animated Logo
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 120, 0, 120)
Logo.Position = UDim2.new(0.5, -60, 0.3, -60)
Logo.Image = "rbxassetid://17091459839"
Logo.BackgroundTransparency = 1
Logo.Parent = LoadingContent

-- Rotate Animation
local rotationTween = game:GetService("TweenService"):Create(
    Logo,
    TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
    {Rotation = 360}
)
rotationTween:Play()

-- Progress Bar
local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0.8, 0, 0, 8)
ProgressBar.Position = UDim2.new(0.1, 0, 0.7, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProgressBar.BorderSizePixel = 0
ProgressBar.ClipsDescendants = true
ProgressBar.Parent = LoadingContent

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(155, 89, 182)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBar

-- Loading Text
local LoadingText = Instance.new("TextLabel")
LoadingText.Size = UDim2.new(1, 0, 0, 30)
LoadingText.Position = UDim2.new(0, 0, 0.8, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Loading Hallow Hub..."
LoadingText.Font = Enum.Font.GothamSemibold
LoadingText.TextColor3 = Color3.fromRGB(200, 200, 200)
LoadingText.TextSize = 18
LoadingText.Parent = LoadingContent

local LoadingSubtext = Instance.new("TextLabel")
LoadingSubtext.Size = UDim2.new(1, 0, 0, 20)
LoadingSubtext.Position = UDim2.new(0, 0, 0.9, 0)
LoadingSubtext.BackgroundTransparency = 1
LoadingSubtext.Text = "Initializing modules"
LoadingSubtext.Font = Enum.Font.Gotham
LoadingSubtext.TextColor3 = Color3.fromRGB(150, 150, 150)
LoadingSubtext.TextSize = 14
LoadingSubtext.Parent = LoadingContent

-- Progress Counter
local ProgressText = Instance.new("TextLabel")
ProgressText.Size = UDim2.new(1, 0, 0, 20)
ProgressText.Position = UDim2.new(0, 0, 0.75, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.Text = "0%"
ProgressText.Font = Enum.Font.GothamBold
ProgressText.TextColor3 = Color3.fromRGB(200, 200, 200)
ProgressText.TextSize = 16
ProgressText.Parent = LoadingContent

-- Load Rayfield while showing loading screen
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create window (hidden behind loading screen)
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Masters DCO",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

-- Animate Progress
local loadDuration = 3
local progress = 0

local tweenInfo = TweenInfo.new(
    loadDuration,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out
)

local progressTween = game:GetService("TweenService"):Create(
    ProgressFill,
    tweenInfo,
    {Size = UDim2.new(1, 0, 1, 0)}
)
progressTween:Play()

-- Update Progress Text
local connection
connection = game:GetService("RunService").Heartbeat:Connect(function()
    local currentWidth = ProgressFill.AbsoluteSize.X
    local totalWidth = ProgressBar.AbsoluteSize.X
    progress = math.floor((currentWidth / totalWidth) * 100)
    ProgressText.Text = progress .. "%"
    
    if progress >= 100 then
        connection:Disconnect()
    end
end)

-- Loading Messages
local messages = {
    "Optimizing performance",
    "Loading assets",
    "Initializing security",
    "Preparing UI components",
    "Almost there..."
}

for i, msg in ipairs(messages) do
    task.wait(loadDuration/#messages)
    LoadingSubtext.Text = msg
end

-- Fade Out Animation
local fadeTween = game:GetService("TweenService"):Create(
    Container,
    TweenInfo.new(0.5),
    {BackgroundTransparency = 1}
)
fadeTween:Play()

-- Cleanup
fadeTween.Completed:Connect(function()
    pcall(function()
        rotationTween:Cancel()
        LoadingGUI:Destroy()
        Rayfield:ToggleVisibility(true) -- Ensure window is visible
    end)
end)

-- Teleporting delay
_G.delay = 0.3 

-- Mode for teleportation (can be 'moveto' or 'cframe')
_G.mode = "moveto" 

-- Path to checkpoints folder
_G.pathtocheckpoints = game:GetService("Workspace").Checkpoints

-- Get the player's current stage from leaderstats
_G.currentCheckpoint = game.Players.LocalPlayer.leaderstats.Stage.Value

local Players = game:GetService("Players")
local T  = Players.LocalPlayer

-- List of specific checkpoints to move to (21, 41, 61, etc.)
local checkpointsToTeleport = {21, 41, 61, 81, 101, 121, 141, 161, 181, 201, 221, 241, 261, 281, 301, 321, 341, 361, 381}
local UserInputService = game:GetService("UserInputService")
local IYMouse = Players.LocalPlayer:GetMouse()
local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local SPEED = 0
local FLYING = false
local vfly = false
local vehicleflyspeed = 50
local iyflyspeed = 5
local QEfly = true

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

local teleportingActive = false 


local function moveToNextCheckpoint()
    task.spawn(function()
        while teleportingActive do
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
            else
                warn("Checkpoint " .. nextCheckpointNum .. " not found.")
                break
            end
        end
    end)
end

local function toggleTeleportation()
    teleportingActive = not teleportingActive

    if teleportingActive then
        Rayfield:Notify({
            Title = "Auto Win Enabled",
            Content = "Teleporting to the end...",
            Duration = 3,
        })
        moveToNextCheckpoint()
    else
        Rayfield:Notify({
            Title = "Auto Win Disabled",
            Content = "Stopped teleporting.",
            Duration = 3,
        })
    end
end

local function FLY()
	FLYING = true
	local BG = Instance.new('BodyGyro')
	local BV = Instance.new('BodyVelocity')
	local rootPart = T.Character and T.Character:FindFirstChild("HumanoidRootPart")
	if rootPart then
		BG.P = 9e4
		BG.Parent = rootPart
		BV.Parent = rootPart
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.CFrame = rootPart.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)

		task.spawn(function()
			repeat wait()
				if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
					Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif SPEED ~= 0 then
					SPEED = 0
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.CFrame = workspace.CurrentCamera.CFrame
			until not FLYING

			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
				Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end

	-- Keybind listeners
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		local key = KEY:lower()
		if key == 'w' then CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif key == 's' then CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif key == 'a' then CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif key == 'd' then CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and key == 'e' then CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed) * 2
		elseif QEfly and key == 'q' then CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed) * 2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)

	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		local key = KEY:lower()
		if key == 'w' then CONTROL.F = 0
		elseif key == 's' then CONTROL.B = 0
		elseif key == 'a' then CONTROL.L = 0
		elseif key == 'd' then CONTROL.R = 0
		elseif key == 'e' then CONTROL.Q = 0
		elseif key == 'q' then CONTROL.E = 0 end
	end)
end


function NOFLY()
    FLYING = false
    if flyKeyDown and flyKeyDown.Disconnect then
        flyKeyDown:Disconnect()
        flyKeyDown = nil
    end
    if flyKeyUp and flyKeyUp.Disconnect then
        flyKeyUp:Disconnect()
        flyKeyUp = nil
    end
    local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
    if humanoid then
        humanoid.PlatformStand = false
    end
    pcall(function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end)
end



local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Button = Menu:CreateButton({
    Name = "Auto Win",
    Interact = 'Changable',
    Callback = function()
        toggleTeleportation()
    end,
})
local Section = Menu:CreateSection("Stage")
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
local Section = Menu:CreateSection("Helpful")
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

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
Section = MoveTab:CreateSection("Fly")
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Fly",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
       if Value then
           FLY()
       else
           NOFLY()
       end
   end,
})

Section = MoveTab:CreateSection("Walk")
Input = MoveTab:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	getgenv().SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	getgenv().NoClip = Value
   	NoClip()
   end,
})
Section = MoveTab:CreateSection("Jump")
Input = MoveTab:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	getgenv().SetJumpPower = Value
   	SetJumpPower()
   end,
})
Toggle = MoveTab:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	getgenv().InfJump = Value
   	InfJump()
   end,
})
