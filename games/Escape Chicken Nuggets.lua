local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Escape Chicken Nugget!",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- workspace.Map["Maze 1 (Default)"].GlobalPortals.GLOBAL_PORTALS.EndPortal["Level 2"]
-- workspace.Map["Maze 1 (Default)"].Coins.Coin.Hitbox.TouchInterest

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
	  pcall(function()
  		for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
  			if part:IsA("BasePart") then
  				if getgenv().NoClip then
  					part.CanCollide = false
  				else
  					part.CanCollide = true
  				end
  			end
  		end
		end)
		wait(0.1)
	end
end

-- Valores
getgenv().AntiDamage = false

-- Locais
local eu = game:GetService("Players").LocalPlayer

-- Funções
-- workspace.Map["Maze 1 (Default)"].Heads:GetChildren()[13].Head
local function AntiDamage()
  while getgenv().AntiDamage == true do
    pcall(function()
      for _, map in pairs(workspace.Map:GetChildren()) do
        if map:FindFirstChild("Heads") then
          for _, nugget in pairs(map.Heads:GetChildren()) do
            if nugget.Head.CanTouch == true then
              nugget.Head.CanTouch = false
            end
          end
        end
      end
    end)
    wait()
  end
  if getgenv().AntiDamage == false then
    pcall(function()
      for _, map in pairs(workspace.Map:GetChildren()) do
        if map:FindFirstChild("Heads") then
          for _, nugget in pairs(map.Heads:GetChildren()) do
            if nugget.Head.CanTouch == false then
              nugget.Head.CanTouch = true
            end
          end
        end
      end
    end)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Helpful")
Toggle =  Menu:CreateToggle({
   Name = "Anti Damage",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiDamage = Value
   	AntiDamage()
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