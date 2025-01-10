-- Rayfield UI setup
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Build A Boat For Treasure!",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

-- Values
getgenv().TreasureAutoFarm = {
    Enabled = false, -- Starts as off
    Teleport = 2, 
    TimeBetweenRuns = 5 
}    

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
-- Movement
local WalkSpeedText = 16
local JumpPowerText = 50
_G.SetWalkSpeed = false
_G.SetJumpPower = false
_G.InfJump = false
_G.NoClip = false                                                                   

                                                                                                                    --player funcs
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

-- AutoFarm function
local function autoFarm(runIndex)
    local character = LocalPlayer.Character
    local stages = Workspace.BoatStages.NormalStages

    for i = 1, 10 do
        local stage = stages["CaveStage" .. i]
        local darknessPart = stage:FindFirstChild("DarknessPart")

        if darknessPart then
            print("Teleporting to stage: " .. i)
            character.HumanoidRootPart.CFrame = darknessPart.CFrame

            local tempPart = Instance.new("Part", character)
            tempPart.Size = Vector3.new(5, 1, 5)
            tempPart.BrickColor = BrickColor.new("Bright blue")
            tempPart.Anchored = true
            tempPart.Position = character.HumanoidRootPart.Position - Vector3.new(0, 6, 0)

            wait(getgenv().TreasureAutoFarm.Teleport or 1)
            tempPart:Destroy()
        end
    end

    print("Teleporting to the end")
    character.HumanoidRootPart.CFrame = stages.TheEnd.GoldenChest.Trigger.CFrame

    local respawned = false
    LocalPlayer.CharacterAdded:Connect(function()
        respawned = true
    end)

    repeat wait() until respawned
    wait(getgenv().TreasureAutoFarm.TimeBetweenRuns or 5)
    print("Run " .. runIndex .. " completed.")
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farms")

-- Toggle AutoFarm button
local autoFarmButton = Menu:CreateButton({
    Name = "Toggle AutoFarm",
    Callback = function()
        getgenv().TreasureAutoFarm.Enabled = not getgenv().TreasureAutoFarm.Enabled
        if getgenv().TreasureAutoFarm.Enabled then
            Rayfield:Notify({
                Title = "AutoFarm Enabled",
                Content = "AutoFarm is now ON.",
                Duration = 4,
            })
            local autoFarmRun = 1
            while getgenv().TreasureAutoFarm.Enabled do
                print("Initializing Auto Farm: Run " .. autoFarmRun)
                autoFarm(autoFarmRun)
                autoFarmRun = autoFarmRun + 1
                wait(1)
            end
        else
            Rayfield:Notify({
                Title = "AutoFarm Disabled",
                Content = "AutoFarm is now OFF.",
                Duration = 4,
            })
        end
    end,
})

local Section = Menu:CreateSection("Player")
local Input = Menu:CreateInput({
   Name = "Player Walk Speed",
   CurrentValue = "",
   Flag = "WalkSpeedInput",
   PlaceholderText = "Default Walk Speed = 16",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	WalkSpeedText = Text
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Toggle Walk Speed",
   CurrentValue = false,
   Flag = "WalkSpeedToggle", 
   Callback = function(Value)
   	_G.SetWalkSpeed = Value
   	SetWalkSpeed()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "No Clip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
   	_G.NoClip = Value
   	NoClip()
   end,
})
local Section = Menu:CreateSection("Jump")
local Input = Menu:CreateInput({
   Name = "Player Jump Power",
   CurrentValue = "",
   Flag = "JumpPowerInput",
   PlaceholderText = "Default Jump Power = 50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	JumpPowerText = Text
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Toggle Jump Power",
   CurrentValue = false,
   Flag = "JumpPowerToggle",
   Callback = function(Value)
   	_G.SetJumpPower = Value
   	SetJumpPower()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Inf Jump",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
   	_G.InfJump = Value
   	InfJump()
   end,
})

local Teleport = Window:CreateTab("Teleport")
local Section = Teleport:CreateSection("Player teleports")

local TeleportRandomPlayerButton = Teleport:CreateButton({
    Name = "Teleport Random Player",
    Info = "Teleport to a random player.",
    Interact = 'Changable',
    Callback = function()
        local randomPlayer = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(randomPlayer.Character.Head.Position.X, randomPlayer.Character.Head.Position.Y, randomPlayer.Character.Head.Position.Z))
        print("Teleported To Random Player")
    end,
})

local Input = Teleport:CreateInput({
    Name = "Player Display Name",
    Info = "Enter the player's display name to teleport to.",
    PlaceholderText = "Player's display name",
    NumbersOnly = false,
    CharacterLimit = 20,
    OnEnter = true,
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        _G.PlayerDisplayName = Text
        print("Selected Display Name: " .. Text)
    end,
})

local Button = Teleport:CreateButton({
    Name = "Teleport to Display Name",
    Info = "Teleport to the player whose display name is entered in the input box.",
    Interact = 'Changable',
    Callback = function()
        local players = game:GetService("Players"):GetPlayers()
        local targetPlayer = nil

        for _, player in ipairs(players) do
            if player.DisplayName == _G.PlayerDisplayName then
                targetPlayer = player
                break
            end
        end

        if targetPlayer then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            print("Teleported to: " .. targetPlayer.DisplayName)
        else
            print("Player with the display name not found.")
        end
    end,
})

local Section = Teleport:CreateSection("teleport tool")

local TeleportToolButton = Teleport:CreateButton({
    Name = "Teleport Tool",
    Info = "Receive a teleport tool for teleporting.",
    Interact = 'Changable',
    Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local mouse = plr:GetMouse()

        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Teleport Tool"

        tool.Activated:Connect(function()
            local root = plr.Character.HumanoidRootPart
            local pos = mouse.Hit.Position + Vector3.new(0, 2.5, 0)
            local offset = pos - root.Position
            root.CFrame = root.CFrame + offset
        end)

        tool.Parent = plr.Backpack
        print("Tool Received")
    end,
})

local Section = Teleport:CreateSection("Zones")

local BlackZoneButton = Teleport:CreateButton({
    Name = "BlackZone",
    Info = "Teleport to BlackZone.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-328.943665, -9.89999294, -72.1218643)
        print("Teleported To BlackZone")
    end,
})

local ReallyBlueZoneButton = Teleport:CreateButton({
    Name = "Really blueZone",
    Info = "Teleport to Really blueZone.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(221.835587, -9.89999294, 289.496735)
        print("Teleported To Really blueZone")
    end,
})

local CamoZoneButton = Teleport:CreateButton({
    Name = "CamoZone",
    Info = "Teleport to CamoZone.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-328.966553, -9.89999294, 285.890778)
        print("Teleported To CamoZone")
    end,
})

local MagentaZoneButton = Teleport:CreateButton({
    Name = "MagentaZone",
    Info = "Teleport to MagentaZone.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(221.835083, -9.89999294, 647.695251)
        print("Teleported To MagentaZone")
    end,
})

local ReallyRedZoneButton = Teleport:CreateButton({
    Name = "Really redZone",
    Info = "Teleport to Really redZone.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(221.835068, -9.89999294, -68.7047195)
        print("Teleported To Really redZone")
    end,
})

local WhiteZoneButton = Teleport:CreateButton({
    Name = "WhiteZone",
    Info = "Teleport to WhiteZone.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-53.5637512, -9.89999294, -345.507538)
        print("Teleported To WhiteZone")
    end,
})

local NewYellerZoneButton = Teleport:CreateButton({
    Name = "New YellerZone",
    Info = "Teleport to New YellerZone.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-328.942108, -9.89999294, 643.876709)
        print("Teleported To New YellerZone")
    end,
})

local Section = Teleport:CreateSection("End Zone")

local WaterSandButton = Teleport:CreateButton({
    Name = "WaterSand",
    Info = "Teleport to WaterSand.",
    Interact = 'Changable',
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-53.5905228, -360.700012, 9499.88184)
        print("Teleported To WaterSand")
    end,
})

-- Credits
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Founder Developer")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Co-Developer")
local Label = Credits:CreateLabel("Discord: _prismx", "at-sign")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
local Button = Credits:CreateButton({
    Name = "Copy Server Link",
    Callback = function()
        setclipboard("discord.gg/AESCuek87s")
        toclipboard("discord.gg/AESCuek87s")
    end,
})
local Section = Credits:CreateSection("Note")
local Label = Credits:CreateLabel("If you find any bug join the discord and open a ticket")
