-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/City%20Destroyer%20Simulator.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | City Destroyer Simulator",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
_G.AutoSoco = false

-- Funções
local function AutoSoco()
	while _G.AutoSoco == true do
		game:GetService("ReplicatedStorage").Punch:FireServer()
		wait(0.01)
	end
end
local WalkSpeedText = 16
local JumpPowerText = 50
_G.SetWalkSpeed = false
_G.SetJumpPower = false
_G.InfJump = false
_G.NoClip = false
_G.PlayerESP = false
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
local function SafeZone()
	local character = game.Players.LocalPlayer.character
	if character then
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		humanoidRootPart.CFrame = CFrame.new(1087.8992919921875, 407.510009765625, -375.97900390625)
 end
end
local CorInocente = Color3.fromRGB(255, 125, 0)
local function PlayerESP()
	while _G.PlayerESP == true do
		for _, player in pairs(workspace:GetChildren()) do
			if player:FindFirstChild("Humanoid") and player:FindFirstChild("Health") then
				if player.Name ~= game.Players.LocalPlayer.Name then
					if player:FindFirstChild("Highlight") then
						if player.Highlight.Enabled == false then
							player.Highlight.Enabled = true
						end
						if player.Highlight.FillColor ~= CorInocente or player.Highlight.OutlineColor ~= CorInocente then
							player.Highlight.FillColor = CorInocente
							player.Highlight.OutlineColor = CorInocente
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.FillColor = CorInocente
						highlight.OutlineColor = CorInocente
						highlight.FillTransparency = 0.4
						highlight.Adornee = player
						highlight.Parent = player
					end
				end
			end
		end
		wait(0.33)
	end

	for _, player in pairs(workspace:GetChildren()) do
		if player:FindFirstChild("Humanoid") and player:FindFirstChild("Health") then
			if player.Name ~= game.Players.LocalPlayer.Name then
				if player:FindFirstChild("Highlight") then
					player.Highlight.Enabled = false
				end
			end
		end
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Helpful")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Punch",
   CurrentValue = false,
   Callback = function(Value)
   	_G.AutoSoco = Value
   	AutoSoco()
   end,
})
local Button = Menu:CreateButton({
   Name = "TP to Safe Zone",
   Callback = function()
       SafeZone()
    end,
})
local Section = Menu:CreateSection("ESP")
local Toggle =  Menu:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Callback = function(Value)
   	_G.PlayerESP = Value
   	PlayerESP()
   end,
})
local ColorPicker = Menu:CreateColorPicker({
    Name = "Innocent Color",
    Color = CorInocente,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorInocente = Value
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