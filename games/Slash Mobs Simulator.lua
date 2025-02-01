-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Slash%20Mobs%20Simulator.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | ⚔️ Slash Mobs Simulator",
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
	  pcall(function()
  		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed ~= WalkSpeedText then
  			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeedText
  		end
		end)
		wait(0.01)
	end
	if getgenv().SetWalkSpeed == false then
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
	end
end
local function SetJumpPower()
	while getgenv().SetJumpPower == true do
	  pcall(function()
	    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
	  end)
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

-- Valores
_G.FastRegen = false
_G.QuestRewards = false
_G.KillAll = false

-- Funções
local function TakeDamageForChildren(children)
	for _, child in pairs(children) do
		pcall(function()
			local takeDamageEvent = game:GetService("ReplicatedStorage").Remote.Event.Fight:FindFirstChild("[C-S]TakeDamage")
			if takeDamageEvent and child:FindFirstChild("Humanoid") then
				takeDamageEvent:FireServer(child.Humanoid)
			end
		end)
	end
end
local function KillAll()
	while _G.KillAll == true do
		for _, roomGroup in pairs({"Room1", "Room2", "Room3"}) do
			for _, room in pairs(workspace[roomGroup]:GetChildren()) do
				if room:FindFirstChild("Mob") then
					TakeDamageForChildren(room.Mob:GetChildren())
				end
			end
		end
		wait(0.05)
	end
end
local function FastRegen()
	while _G.FastRegen == true do
		game:GetService("ReplicatedStorage").Remote.Event.Up:FindFirstChild("[C-S]TryRegen"):FireServer(1)
		wait(0.0001)
	end
end
local function GetCodes()
	game:GetService("ReplicatedStorage").CdkRewardFuntion.isPlayerUseCdkRequest:InvokeServer("SLASHRELEASE")
	game:GetService("ReplicatedStorage").CdkRewardFuntion.isPlayerUseCdkRequest:InvokeServer("2000likes")
end
local function QuestRewards()
	while _G.QuestRewards == true do
		for q = 1, 2 do
			local questie = "Q" .. q
			game:GetService("ReplicatedStorage").Remote.Event.DailyMission:FindFirstChild("[C-S]PlayerGetReward"):FireServer(questie)
		end
		wait(0.5)
	end
end
local function DoChallenge()
	game:GetService("ReplicatedStorage").Remote.Event.Eco:FindFirstChild("[C-S]Trybreakthrough"):FireServer()
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Combat")
local Toggle =  Menu:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Callback = function(Value)
   	_G.KillAll = Value
   	KillAll()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Fast Regen",
   CurrentValue = false,
   Callback = function(Value)
   	_G.FastRegen = Value
   	FastRegen()
   end,
})
local Button = Menu:CreateButton({
   Name = "Start Challenge",
   Callback = function()
   	DoChallenge()
    end,
})
local Section = Menu:CreateSection("Extra")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Gems (Slow)",
   CurrentValue = false,
   Callback = function(Value)
   	_G.QuestRewards = Value
   	QuestRewards()
   end,
})
local Button = Menu:CreateButton({
   Name = "Reedem Codes",
   Callback = function()
   	GetCodes()
    end,
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