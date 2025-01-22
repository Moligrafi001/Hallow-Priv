local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Destruction Simulator",
    Icon = 17091459839,
    LoadingTitle = "HallowHub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})


-- Locais
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local lplr = game:GetService("Players").LocalPlayer
local rstorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

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

-- Window 
local windowTab = Window:CreateTab("Main", "home")
local section = windowTab:CreateSection("OP auto coin", true)
local isAutoAddingCoins = false
local coin = windowTab:CreateToggle({
    Name = "Auto Coin (OP)",
    Callback = function()

        isAutoAddingCoins = not isAutoAddingCoins

        if isAutoAddingCoins then
            while isAutoAddingCoins do
                local Event = ReplicatedStorage.Remotes.generateBoost
                Event:FireServer("Coins", 999999, 18959994)  -- Automatically add 1,000,000 coins
                wait(0.1)  -- Wait for 0.1 seconds before firing again
            end
        end
    end
})
local section = windowTab:CreateSection("Area Destroyer", true)
local AddLevelButton = windowTab:CreateButton({
    Name = "Explode Area You Are Standing In (must be in a area)",
    Callback = function()
        local launcher = lplr.Character:FindFirstChild("Launcher") or lplr.Backpack:FindFirstChild("Launcher")
        
        if not launcher then
            Rayfield:Notify({
                Title = "Error",
                Content = "No launcher found in your inventory or equipped!",
                Duration = 3,
                Type = "Error"
            })
            return
        end

        local currentAreaName = lplr:FindFirstChild("CurrentArea") and lplr.CurrentArea.Value
        if not currentAreaName then
            Rayfield:Notify({
                Title = "Error",
                Content = "CurrentArea value not found for the player!",
                Duration = 3,
                Type = "Error"
            })
            return
        end

        local area = workspace:FindFirstChild("Areas"):FindFirstChild(currentAreaName)
        if not area then
            Rayfield:Notify({
                Title = "Not Standing in an area",
                Content = "You MUST be standing in a area for this to work",
                Duration = 3,
                Type = "Error"
            })
            return
        end

        local rstorage = game:GetService("ReplicatedStorage")

        for _, v in pairs(area:GetDescendants()) do
            if v:IsA("BasePart") then
                rstorage.Remotes.explodeRocket:FireServer(tick(), launcher.Stats, v.Position, launcher.Assets.Rocket.Boom)
            end
        end

        Rayfield:Notify({
            Title = "Success",
            Content = "Exploded all parts in " .. currentAreaName .. "!",
            Duration = 3,
            Type = "Success"
        })
    end
})
local RankUpButton = windowTab:CreateButton({
    Name = "Rank Up (must be max level)",
    Callback = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("rankUp"):FireServer()
    end
})
local GiveAllBoostsButton = windowTab:CreateButton({
    Name = "Get All Boosts",
    Callback = function()
        local boosts = {

            { "BrickBoost", 180, 2 },

            { "CoinBoost", 180, 2 },

            { "Coins", 999999, 1000000 },

            { "ExtraSpeed", 180, 2 },

            { "Levels", 480, 55 },

            { "SuperJump", 180, 2 },

            { "XPBoost", 180, 2 }
        }

        for _, args in ipairs(boosts) do
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("generateBoost"):FireServer(unpack(args))
        end
    end
})

-- Movement
local MoveTab = Window:CreateTab("Movement", "chevrons-up")
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