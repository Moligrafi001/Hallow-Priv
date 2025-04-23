local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Toque",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().KillAura = false
getgenv().AutoPower = false
getgenv().AutoAura = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Selected = "bubblesplosion",
  Golpes = { "laser-focus", "flame-jet", "punch", "bubblesplosion" },
  Cooldown = 0.1
}

-- Funções
local function KillAura()
  while getgenv().KillAura and (task.wait(Settings.Cooldown) or task.wait(0.1)) do
    pcall(function()
      for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= eu then
          if Settings.Selected == "punch" then
            game:GetService("ReplicatedStorage").Hit:FireServer(p.Character, "punch", { sequenceIndex = 2 })
          else
            game:GetService("ReplicatedStorage").Hit:FireServer(p.Character, Settings.Selected)
          end
        end
      end
    end)
  end
end
local function AutoPower()
  while getgenv().AutoPower and task.wait(0.33) do
    pcall(function()
      game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.OpenCrate:InvokeServer("normal-power-crate")
      game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.FinishReached:InvokeServer()
    end)
  end
end
local function AutoAura()
  while getgenv().AutoAura and task.wait(0.33) do
    pcall(function()
      game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.OpenCrate:InvokeServer("normal-aura-crate")
      game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.FinishReached:InvokeServer()
    end)
  end
end

local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Combat")
Dropdown = Menu:CreateDropdown({
   Name = "Selected Skill",
   Options = Settings.Golpes,
   CurrentOption = {Settings.Selected},
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.Selected = Options[1]
   end,
})
Dropdown = Menu:CreateDropdown({
   Name = "Kill Aura Speed",
   Options = {"Slow", "Normal", "Fast"},
   CurrentOption = {"Normal"},
   MultipleOptions = false,
   Callback = function(Options)
   		if Options[1] == "Normal" then
   		  Settings.Cooldown = 0.1
   		elseif Options[1] == "Slow" then
   		  Settings.Cooldown = 0.2
   		elseif Options[1] == "Fast" then
   		  Settings.Cooldown = 0.05
   		end
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().KillAura = Value
   	KillAura()
   end,
})
Section = Menu:CreateSection("Aura Crate [ 80 Coins ]")
Button = Menu:CreateButton({
   Name = "Open Aura Crate",
   Callback = function()
   	game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.OpenCrate:InvokeServer("normal-aura-crate")
   	task.wait(0.3)
    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.FinishReached:InvokeServer()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Aura Crate",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoAura = Value
   	AutoAura()
   end,
})
Section = Menu:CreateSection("Power Crate [ 250 Coins ]")
Button = Menu:CreateButton({
   Name = "Open Power Crate",
   Callback = function()
   	game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.OpenCrate:InvokeServer("normal-power-crate")
   	task.wait(0.3)
    game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").knit.Knit.Services.CrateService.RF.FinishReached:InvokeServer()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Power Crate",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoPower = Value
   	AutoPower()
   end,
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