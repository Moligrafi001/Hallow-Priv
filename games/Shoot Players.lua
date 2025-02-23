local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Shoot Players",
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
getgenv().Triggerbot = false
getgenv().AutoCash = false
getgenv().AutoAirdrop = false
getgenv().AntiDeath = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local IsWaiting = false

-- Funções
local function Triggerbot()
  while getgenv().Triggerbot do
    pcall(function()
      for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= eu then
          for _, tool in pairs(eu.Character:GetChildren()) do
            local distance = (eu.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if tool:IsA("Tool") and distance <= 30 and workspace:Raycast(eu.Character.HumanoidRootPart.Position, (p.Character.HumanoidRootPart.Position - eu.Character.HumanoidRootPart.Position).Unit * 30, RaycastParams.new({FilterDescendantsInstances = {eu.Character}})) then  
              tool.RemoteBridge:FireServer(p.Character.HumanoidRootPart.Position)
            end
          end
        end
      end
    end)
    task.wait(0.1)
  end
end
local function AutoCash()
  while getgenv().AutoCash do
    pcall(function()
      for _, m in pairs(workspace.Cash:GetDescendants()) do
        if m:IsA("TouchTransmitter") then
          firetouchinterest(eu.Character.HumanoidRootPart, m.Parent, 0)
          firetouchinterest(eu.Character.HumanoidRootPart, m.Parent, 1)
        end
      end
    end)
    task.wait(0.01)
  end
end
local function AutoAirdrop()
  while getgenv().AutoAirdrop do
    pcall(function()
      for _, a in pairs(workspace.Airdrops:GetChildren()) do
        for _, p in pairs(a:GetDescendants()) do
          if p:IsA("ProximityPrompt") and getgenv().AutoAirdrop and not IsWaiting then
            IsWaiting = true
            eu.Character.HumanoidRootPart:SetAttribute("Hallow_Hub", eu.Character.HumanoidRootPart.CFrame)
            eu.Character.HumanoidRootPart.CFrame = p.Parent.CFrame
            task.wait(0.3)
            fireproximityprompt(p)
            task.wait(0.2)
            eu.Character.HumanoidRootPart.CFrame = eu.Character.HumanoidRootPart:GetAttribute("Hallow_Hub")
            IsWaiting = false
          end
        end
      end
    end)
    task.wait(0.1)
  end
  if not getgenv().AutoAirdrop then
  end
end
local function AntiDeath()
  if getgenv().AntiDeath then
    workspace.DeathPart.CanCollide = true
    workspace.DeathPart.CanTouch = false
  else
    workspace.DeathPart.CanCollide = false
    workspace.DeathPart.CanTouch = true
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Combat")
Toggle =  Menu:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Triggerbot = Value
   	Triggerbot()
   end,
})
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Cash",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCash = Value
   	AutoCash()
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Airdrops",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoAirdrop = Value
   	AutoAirdrop()
   end,
})
Section = Menu:CreateSection("Helpful")
Toggle =  Menu:CreateToggle({
   Name = "Anti Death Part",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AntiDeath = Value
   	AntiDeath()
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