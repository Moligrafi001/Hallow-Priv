local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | [⭐] Murderers VS Sheriffs",
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
getgenv().HitBox = false
getgenv().PlayerESP = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local HitSize = 9
local CorInocente = Color3.fromRGB(255, 125, 0)

-- Funções
local function Triggerbot()
  while getgenv().Triggerbot == true do
    pcall(function()
      local function RayOn(part)
        local ray = Ray.new(game.Workspace.CurrentCamera.CFrame.Position, (part.Position - game.Workspace.CurrentCamera.CFrame.Position).unit * 1000)
        local hitPart, hitPosition = workspace:FindPartOnRay(ray, eu.Character)
        if hitPart and hitPart.Parent == part.Parent then
          return true
        end
        return false
      end
      for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= eu and player.Teamm.Value ~= eu.Teamm.Value and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health >= 1 and player.Character:FindFirstChild("HumanoidRootPart") then
          pcall(function()
            if RayOn(player.Character.HumanoidRootPart) and RayOn(player.Character.Head) then
              for _, tool in pairs(eu.Character:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("FireWeapon") then
                  tool.FireWeapon:FireServer(player.Character.HumanoidRootPart.Position)
                end
              end
            end
          end)
        end
      end
    end)
    wait()
  end
end
local function HitBox()
	while getgenv().HitBox == true do
	  pcall(function()
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= eu and player.Teamm.Value ~= eu.Teamm.Value then
				if player.Character then
					if player.Character:FindFirstChild("HumanoidRootPart") then
						if player.Character.HumanoidRootPart.Size ~= Vector3.new(HitSize, HitSize, HitSize) or player.Character.HumanoidRootPart.Transparency ~= 0.6 then
							player.Character.HumanoidRootPart.Size = Vector3.new(HitSize, HitSize, HitSize)
							player.Character.HumanoidRootPart.Transparency = 0.6
							player.Character.HumanoidRootPart.CanCollide = false
						end
					end
				end
			end
		end
	  end)
		wait()
	end
	if getgenv().HitBox == false then
		for _, player in pairs(game.Players:GetPlayers()) do
			if player ~= game.Players.LocalPlayer then
				if player.Character and game.Players.LocalPlayer.Character then
					if player.Character:FindFirstChild("HumanoidRootPart") then
						if player.Character.HumanoidRootPart.Size ~= Vector3.new(2, 2, 1) or player.Character.HumanoidRootPart.Transparency ~= 0 then
							player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
							player.Character.HumanoidRootPart.Transparency = 0
						end
					end
				end
			end
		end
	end
end
local function PlayerESP()
	while getgenv().PlayerESP == true do
	  pcall(function()
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if player and player.Parent and players.Teamm.Value ~= eu.Teamm.Value then
				if player ~= game.Players.LocalPlayer.Character then
					if player:FindFirstChild("Highlight") then
						if player.Highlight.Enabled == false then
							player.Highlight.Enabled = true
						elseif player.Highlight.Enabled == true and player.Humanoid.Health <= 0 then
						  player:Destroy()
						end
						if player.Highlight.FillColor ~= CorInocente or player.Highlight.OutlineColor ~= CorInocente then
						  player.Highlight.FillColor = CorInocente
						  player.Highlight.OutlineColor = CorInocente
						end
					else
						local highlight = Instance.new("Highlight")
						highlight.FillColor = CorInocente
						highlight.OutlineColor = CorInocente
						highlight.FillTransparency = 0.6
						highlight.Adornee = player
						highlight.Parent = player
					end
				end
			end
		end
		end)
		wait(0.33)
	end
	if getgenv().PlayerESP == false then
		for _, players in pairs(game.Players:GetPlayers()) do
			local player = players.Character
			if player and players.Teamm.Value ~= eu.Teamm.Value and player:FindFirstChild("Highlight") then
				if player.Highlight.Enabled == true then
					player.Highlight.Enabled = false
				end
			end
		end
	end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Aim Assistant")
Toggle =  Menu:CreateToggle({
   Name = "Triggerbot",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().Triggerbot = Value
   	Triggerbot()
   end,
})
Section = Menu:CreateSection("Player ESP")
Toggle =  Menu:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().PlayerESP = Value
   	PlayerESP()
   end,
})
ColorPicker = Menu:CreateColorPicker({
    Name = "ESP Color",
    Color = CorInocente,
    Flag = "ColorPicker1",
    Callback = function(Value)
    	CorInocente = Value
    end
})
Section = Menu:CreateSection("Hitbox Expander")
Input = Menu:CreateInput({
   Name = "Hitbox Size",
   CurrentValue = "",
   PlaceholderText = "Default HitBox Size = 9",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	HitSize = Text
   end,
})
Toggle =  Menu:CreateToggle({
   Name = "Expand Hitboxes",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().HitBox = Value
   	HitBox()
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